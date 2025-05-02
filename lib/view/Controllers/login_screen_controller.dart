import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/login_model.dart';

class LoginScreenController with ChangeNotifier {
  bool isloading = false;
  String? errorMessage;
// No GoogleSignIn needed anymore - we'll use WebView

  // Only need to update the handleGoogleAuthCallback method
 Future<void> handleGoogleAuthCallback(Uri uri, BuildContext context) async {
  try {
    final code = uri.queryParameters['code'];
    
    if (code == null) {
      throw Exception('No authorization code received');
    }

    log("Exchanging code for tokens...");
    
    // Extract the full callback URL that failed to load
    final failedCallbackUrl = uri.toString();
    log("Failed callback URL: $failedCallbackUrl");

    // Parse the code from the URL
    final extractedCode = Uri.parse(failedCallbackUrl).queryParameters['code'];
    
    if (extractedCode == null) {
      throw Exception('Could not extract code from callback URL');
    }

    // Manually call your backend callback endpoint
    final response = await http.post(
      Uri.parse('http://192.168.3.36:8000/auth/google/callback/'),
      body: {
        'code': extractedCode,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storeAuthData(data);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
      );
    } else {
      throw Exception('Failed to exchange code for tokens: ${response.body}');
    }
  } catch (e) {
    log('Google auth error: $e');
    _showError(context, 'Authentication failed: ${e.toString()}');
    
    // Optional: Add a retry button in the error message
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Authentication Error"),
          content: Text("Would you like to try again?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // signInWithGoogle(context);
              },
              child: Text("Retry"),
            ),
          ],
        ),
      );
    }
  }
}






Future<void> handleGoogleAuthCode(String code, BuildContext context) async {
  try {
    log("Exchanging code for tokens...");
    final response = await http.post(
      Uri.parse('http://192.168.3.36:8000/auth/google/callback/'),
      body: {
        'code': code,
        'grant_type': 'authorization_code',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _storeAuthData(data);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
        );
      }
    } else {
      throw Exception('Failed to exchange code: ${response.body}');
    }
  } catch (e) {
    log('Google auth error: $e');
    if (context.mounted) {
      _showError(context, 'Authentication failed: ${e.toString()}');
    }
  }
}

  Future<void> _storeAuthData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access', data['access_token']);
    log("✅ Saved Access Token: ${prefs.getString('access')}");
    await prefs.setString('refresh', data['refresh_token']);
    await prefs.setString('user_email', data['user']['email'] ?? '');
    await prefs.setString('user_name', data['user']['name'] ?? '');
    await prefs.setString(
        'user_avatar', data['user']['profile_picture_google'] ?? '');
  }

  void _showError(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  Future<bool> onLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse("http://192.168.3.36:8000/users/api/token/");
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response =
          await http.post(url, body: {"email": email, "password": password});

      if (response.statusCode == 200) {
        LoginModel loginModel = loginModelFromJson(response.body);

        if (loginModel.access != null && loginModel.access!.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("access", loginModel.access!);
          await prefs.setString("refresh", loginModel.refresh!);
          // Log saved tokens
          log("✅ Saved Access Token: ${prefs.getString('access')}");
          log("✅ Saved Refresh Token: ${prefs.getString('refresh')}");
          // Navigate on success
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CustomBottomNavbar(),
              ));
        } else {
          errorMessage = "Invalid token received";
        }
        return true;
      } else {
        errorMessage = "Login failed: ${response.statusCode}";
      }
      return false;
    } catch (e) {
      errorMessage = "Connection error: ${e.toString()}";
      log(e.toString());
      return false;
    } finally {
      isloading = false;
      notifyListeners();

      // Show error message if exists
      if (errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
      return false;
    }
  }
}
