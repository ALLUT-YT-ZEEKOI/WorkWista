import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/register_model.dart';

class RegisterScreenController with ChangeNotifier {
  bool isloading = false;
  String? erroMessage;

  Future onRegister(
    
      {required String name,
      required BuildContext context,
      required String email,
      required String phone_number,
      required String DOB,
      required String password,
      required String confirm_pass}) async {
    final url = Uri.parse("https://workwista.com/users/register/");
    isloading = true;
    erroMessage = null;
    notifyListeners();

    try {
      final respnse = await http.post(url, body: {
        "name": name,
        "email": email,
        "phone_number": phone_number,
        "DOB": DOB,
        "password": password,
        "confirm_pass": confirm_pass
      });

      if (respnse.statusCode == 200) {
        RegisterModel registerModel = registerModelFromJson(respnse.body);

        final accessToken = registerModel.data?.accessToken;
        final refreshToken = registerModel.data?.refreshToken;
        if (accessToken != null && accessToken.isNotEmpty) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("access", accessToken);
          await prefs.setString("refresh", refreshToken!);
             // Log saved tokens
          log("✅ Saved Access Token: ${prefs.getString('access')}");
          log("✅ Saved Refresh Token: ${prefs.getString('refresh')}");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CustomBottomNavbar(),
              ));
        }
        else{
          erroMessage = "Invalid token received";
        }


      }else{
        erroMessage = "Registration failed: ${respnse.statusCode}";
      }
    } catch (e) {
      erroMessage =  "Connection error: ${e.toString()}";
      log(e.toString());

    }finally{
      isloading = false;
      notifyListeners();

       // Show error message if exists
      if (erroMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(erroMessage!)),
        );
      }
    }
  }
}
