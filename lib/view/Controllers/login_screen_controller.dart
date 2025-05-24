import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/login_model.dart';

class LoginScreenController with ChangeNotifier {
  bool isloading = false;
  bool isloadingG = false;
  String? generalError;
// No GoogleSignIn needed anymore - we'll use WebView

//   // Only need to update the handleGoogleAuthCallback method
//  Future<void> handleLoginResponse(Map<String, dynamic> data, BuildContext context) async {
//     try {
//       await _storeAuthData(data);
//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
//         );
//       }
//     } catch (e) {
//       log('handleLoginResponse error: $e');
//       if (context.mounted) {
//         _showError(context, 'Login failed: ${e.toString()}');
//       }
//     }
//   }

//   Future<void> _storeAuthData(Map<String, dynamic> data) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('access', data['access_token']);
//     log("✅ Saved Access Token: ${prefs.getString('access')}");
//     await prefs.setString('refresh', data['refresh_token']);
//     await prefs.setString('user_email', data['user']['email'] ?? '');
//     await prefs.setString('user_name', data['user']['name'] ?? '');
//     await prefs.setString(
//         'user_avatar', data['user']['profile_picture_google'] ?? '');
//   }

  // void _showError(BuildContext context, String message) {
  //   if (context.mounted) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(message)),
  //     );
  //   }
  // }

// Field-wise error tracking
  Map<String, String?> fieldErrors = {
    "email": null,
    "password": null,
  };

  void clearErrors() {
    fieldErrors.updateAll((key, value) => null);
    generalError = null;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId:
          '877049429462-45rfki3okpgcl8nrevnr3bc9vi0420ou.apps.googleusercontent.com' //web cleint id from cloud console
      );

  Future<void> handleGoogleSignIn({required BuildContext context}) async {
    isloadingG = true;
    notifyListeners();
    // final url = Uri.parse("https://workwista.com/google_mobile_auth/");

    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? auth = await account?.authentication;
      final String? idToken = auth?.idToken;
      // log("id toke :${idToken.toString()}");

      if (idToken == null) {
        // log("id toke :${idToken.toString()}");
        log('Failed to get ID Token');
        return;
      }

      final response = await http.post(
        Uri.parse('https://workwista.com/google_mobile_auth/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );
      log("id toke :${idToken.toString()}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final user = data['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access", accessToken);
        await prefs.setString("refresh", refreshToken);
        await prefs.setString("profile_data", jsonEncode(user));
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
        final errorData = jsonDecode(response.body);
        log(errorData['error'] ?? 'server error');
      }
    } catch (e) {
      log('sign in error : $e');
    } finally {
      isloadingG = false;
      notifyListeners();
    }
  }

 Future<bool> onLogin({
  required String email,
  required String password,
  required BuildContext context
}) async {
  final url = Uri.parse("https://workwista.com/users/api/token/");
  isloading = true;
  clearErrors(); // Clear previous errors
  notifyListeners();

  try {
    final response = await http.post(url, body: {
      "email": email, 
      "password": password
    });

    if (response.statusCode == 200) {
      LoginModel loginModel = loginModelFromJson(response.body);

      if (loginModel.access != null && loginModel.access!.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access", loginModel.access!);
        await prefs.setString("refresh", loginModel.refresh!);
        
        log("✅ Saved Access Token: ${prefs.getString('access')}");
        log("✅ Saved Refresh Token: ${prefs.getString('refresh')}");
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
        );
        return true;
      } else {
        generalError = "Invalid token received";
      }
    } else if (response.statusCode == 400) {
      // Handle field-specific errors
      final decoded = json.decode(response.body);
      decoded.forEach((key, value) {
        if (fieldErrors.containsKey(key)) {
 fieldErrors[key] = (value as List).join(', ');
        } else {
          generalError = (value as List).join(', ');
        }
      });
    } else {
      generalError = "Login failed: ${response.statusCode}";
      log(response.body.toString());
    }
    
    return false;
  } catch (e) {
    generalError = "Connection error: ${e.toString()}";
    log(e.toString());
    return false;
  } finally {
    isloading = false;
    notifyListeners();
  }
}
}
