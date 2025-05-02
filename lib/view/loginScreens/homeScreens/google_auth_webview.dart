// google_auth_service.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';

class GoogleAuthService {
  static const String callbackScheme = 'ya';
  static const String backendAuthUrl = 'http://192.168.3.36:8000/auth/google/';

  static Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Add a random state parameter to track the request
      final state = DateTime.now().millisecondsSinceEpoch.toString();
      final authUrl = '$backendAuthUrl?state=$state';
      
      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: callbackScheme,
      );

      // This will now capture both successful and failed redirects
      final uri = Uri.parse(result);
      
      if (uri.toString().contains('localhost')) {
        // Extract the code from the failed localhost URL
        final code = uri.queryParameters['code'];
        if (code != null) {
          // Manually process the code
          await context.read<LoginScreenController>()
            .handleGoogleAuthCode(code, context);
          return;
        }
      }
      
      // Normal processing for non-localhost URLs
      context.read<LoginScreenController>()
        .handleGoogleAuthCallback(uri, context);
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google sign-in failed: ${e.toString()}')),
        );
      }
    }
  }
}
