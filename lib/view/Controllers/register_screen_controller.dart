import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/register_model.dart';

class RegisterScreenController with ChangeNotifier {
  bool isloading = false;
  String? generalError;

  // Field-wise error tracking
  Map<String, String?> fieldErrors = {
    "name": null,
    "email": null,
    "phone_number": null,
    "DOB": null,
    "password": null,
    "confirm_pass": null,
  };

  void clearErrors() {
    fieldErrors.updateAll((key, value) => null);
    generalError = null;
  }

  Future<void> onRegister({
    required String name,
    required BuildContext context,
    required String email,
    required String phone_number,
    required String DOB,
    required String password,
    required String confirm_pass,
  }) async {
    final url = Uri.parse("https://workwista.com/users/register/");
    isloading = true;
    clearErrors();
    notifyListeners();

    try {
      final response = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone_number": phone_number,
        "DOB": DOB,
        "password": password,
        "confirm_pass": confirm_pass
      });

      if (response.statusCode == 200) {
        RegisterModel registerModel = registerModelFromJson(response.body);
        final accessToken = registerModel.data?.accessToken;
        final refreshToken = registerModel.data?.refreshToken;

        if (accessToken != null && accessToken.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("access", accessToken);
          await prefs.setString("refresh", refreshToken ?? "");

          log("✅ Saved Access Token: ${prefs.getString('access')}");
          log("✅ Saved Refresh Token: ${prefs.getString('refresh')}");

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
          );
        } else {
          generalError = "Invalid token received";
        }
      } else if (response.statusCode == 400) {
        final decoded = json.decode(response.body);
        decoded.forEach((key, value) {
          if (fieldErrors.containsKey(key)) {
            fieldErrors[key] = (value as List).join(', ');
          } else {
            generalError = (value as List).join(', ');
          }
        });
      } else {
        generalError = "Registration failed: ${response.statusCode}";
        log(response.body.toString());
      }
    } catch (e) {
      generalError = "Connection error: ${e.toString()}";
      log(e.toString());
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
}
