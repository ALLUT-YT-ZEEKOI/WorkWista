
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
 Future<void> handleLoginResponse(Map<String, dynamic> data, BuildContext context) async {
    try {
      await _storeAuthData(data);
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
        );
      }
    } catch (e) {
      log('handleLoginResponse error: $e');
      if (context.mounted) {
        _showError(context, 'Login failed: ${e.toString()}');
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
    final url = Uri.parse("https://workwista.com/users/api/token/");
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
