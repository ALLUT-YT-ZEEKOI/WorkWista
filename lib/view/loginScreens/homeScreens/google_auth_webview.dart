// google_auth_service.dart
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';

class GoogleAuthService {
  static const String backendAuthUrl = 'https://workwista.com/auth/google/';

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log("Google Sign-In cancelled");
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        throw Exception('Failed to get ID token from Google');
      }

      // Send token to your backend API
      final response = await http.post(
        Uri.parse(backendAuthUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'id_token': idToken,
          'access_token': accessToken,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        log("Backend login successful: $responseData");

        // Call your controller logic with response
        context.read<LoginScreenController>().handleLoginResponse(responseData, context);
      } else {
        log('Backend login failed: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backend login failed: ${response.body}')),
        );
      }
    } catch (e) {
      log("Google login error: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google login error: $e')),
        );
      }
    }
  }
}
