import 'dart:convert';
import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/Utils/app_utils.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/login_model.dart';
import 'package:workwista/view/loginScreens/homeScreens/complete_profile_screen.dart';

class LoginScreenController with ChangeNotifier {
  bool isloading = false;
  bool isloadingG = false;
  String? generalError;

  // Field-wise error tracking
  Map<String, String?> fieldErrors = {
    "email": null,
    "password": null,
  };

  void clearErrors() {
    fieldErrors.updateAll((key, value) => null);
    generalError = null;
    notifyListeners();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId:
          '877049429462-45rfki3okpgcl8nrevnr3bc9vi0420ou.apps.googleusercontent.com' //web client id from cloud console
      );

  Future<void> handleGoogleSignIn({required BuildContext context}) async {
    isloadingG = true;
    clearErrors();
    notifyListeners();

    try {
      // First, sign out to clear any cached authentication
      await _googleSignIn.signOut();

      // Then initiate a fresh sign-in which will show account picker
      final GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account == null) {
        // User cancelled the sign-in
        log('User cancelled Google Sign-In');
        return;
      }

      final GoogleSignInAuthentication? auth = await account.authentication;
      final String? idToken = auth?.idToken;

      if (idToken == null) {
        log('Failed to get ID Token');
        generalError = "Failed to authenticate with Google";
        notifyListeners();
        return;
      }

      final response = await http.post(
        Uri.parse('https://workwista.com/google_mobile_auth/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': idToken}),
      );

      log("ID Token: ${idToken.toString()}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final accessToken = data['access_token'];
        final refreshToken = data['refresh_token'];
        final verified = data['verified'];
        final user = data['user'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("access", accessToken);
        await prefs.setString("refresh", refreshToken);
        await prefs.setString("profile_data", jsonEncode(user));

        // Log saved tokens
        log("✅ Saved Access Token: ${prefs.getString('access')}");
        log("✅ Saved Refresh Token: ${prefs.getString('refresh')}");
        log("-------------------------------------");
        log("logging user: ${user.toString()}");
        log("logging email: ${user['email'].toString()}");
        log("logging phone: ${user['phone_number'].toString()}");
        log("logging DOB: ${user['date_of_birth'].toString()}");
        log(verified.toString());

        // Sign out again after successful authentication to clear cache for next time
        await _googleSignIn.signOut();

        if (verified == false) {
          log("navigating to profile completion");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CompleteProfileScreen(),
              ));
        } else if (verified == true) {
          log("navigating to main screen");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CustomBottomNavbar(),
              ));
        }
      } else {
        final errorData = jsonDecode(response.body);
        generalError = errorData['error'] ?? 'Server error occurred';
        log(generalError!);
      }
    } catch (e) {
      log('Sign in error: $e');
      generalError = 'Sign in failed: ${e.toString()}';
    } finally {
      isloadingG = false;
      notifyListeners();
    }
  }

  // Method to explicitly sign out (can be called when user logs out of the app)
  Future<void> signOutGoogle() async {
    try {
      await _googleSignIn.signOut();
      log('Google Sign-Out successful');
    } catch (e) {
      log('Google Sign-Out error: $e');
    }
  }

  Future<bool> onLogin(
      {required String email,
      required String password,
      required BuildContext context}) async {
    final url = Uri.parse("https://workwista.com/users/api/token/");
    isloading = true;
    clearErrors(); // Clear previous errors
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

        // Check if it's a field-specific error structure
        bool hasFieldErrors = false;
        decoded.forEach((key, value) {
          if (fieldErrors.containsKey(key)) {
            fieldErrors[key] =
                (value is List) ? value.join(', ') : value.toString();
            hasFieldErrors = true;
          }
        });

        // If no field-specific errors, treat as general error
        if (!hasFieldErrors) {
          if (decoded.containsKey('detail')) {
            generalError = decoded['detail'];
          } else if (decoded.containsKey('error')) {
            generalError = decoded['error'];
          } else {
            // If it's a list of errors, join them
            String errorMessage = '';
            decoded.forEach((key, value) {
              if (value is List) {
                errorMessage += value.join(', ') + ' ';
              } else {
                errorMessage += value.toString() + ' ';
              }
            });
            generalError = errorMessage.trim();
          }
        }
      } else if (response.statusCode == 401) {
        generalError = "Invalid email or password";
      } else {
        generalError = "Login failed. Please try again.";
        log("Login failed with status ${response.statusCode}: ${response.body}");
      }

      return false;
    } catch (e) {
      generalError = "Connection error. Please check your internet connection.";
      log("Login error: ${e.toString()}");
      return false;
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
