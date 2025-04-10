import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/login_model.dart';
import 'package:workwista/view/loginScreens/homeScreens/dashboard_screen.dart';

class LoginScreenController with ChangeNotifier {
  bool isloading = false;
  String? errorMessage;

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
                builder: (context) => Dashboard(),
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
