import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/Utils/app_utils.dart';

import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/profile_update_model.dart';
import 'package:workwista/view/loginScreens/homeScreens/lottie_dialog.dart';

class CompleteProfileController with ChangeNotifier {
  bool isLoading = false;
  String? generalError;

  Map<String, String?> fieldErrors = {
    "phone_number": null,
    "DOB": null,
    "name": null,
  };

  void clearErrors() {
    fieldErrors.updateAll((key, value) => null);
    generalError = null;
  }

  Future<void> onUpdateProfile({
    required String phone_number,
    required String DOB,
    required String name,
    required String fcm_token,
    required BuildContext context,
  }) async {
    isLoading = true;
    clearErrors();
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access") ?? "";
    String refreshToken = prefs.getString("refresh") ?? "";

    try {
      var response = await _makeProfileUpdateRequest(
          accessToken, phone_number, DOB, name, fcm_token);

      if (response.statusCode == 401) {
        log("Access token expired, refreshing...");
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          response = await _makeProfileUpdateRequest(
              newAccessToken, phone_number, DOB, name, fcm_token);
        }
      }

      if (response.statusCode == 200) {
        UpdateProfileModel updateModel =
            updateProfileModelFromJson(response.body);
        log("Profile updated successfully");

       showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => const LottieDialog(),
);

        log(updateModel.message.toString());
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
        generalError = "Failed to update profile (${response.statusCode})";
        log(response.body);
      }
    } catch (e) {
      generalError = "Connection error: ${e.toString()}";
      log(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();

      if (generalError != null && context.mounted) {
        AppUtils.showSnackbar(
            context: context,
            message: generalError.toString(),
            bgcolor: Colors.red);
      }
    }
  }

  Future<http.Response> _makeProfileUpdateRequest(
    String token,
    String phone_number,
    String DOB,
    String name,
    String fcm_token,
  ) async {
    final url = Uri.parse("https://workwista.com/complete/profile/");
    var request = http.MultipartRequest('POST', url);
    log(name);
    log(fcm_token.toString());

    request.fields['phone_number'] = phone_number;
    request.fields['DOB'] = DOB;
    request.fields['name'] = name;
    request.fields['fcm_token'] = fcm_token;
    request.headers['Authorization'] = 'Bearer $token';

    final streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final url = Uri.parse('https://workwista.com/users/api/token/refresh/');
      final response = await http.post(
        url,
        body: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        final newTokens = jsonDecode(response.body);
        final newAccessToken = newTokens['access'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access", newAccessToken);

        log("Access token refreshed");
        return newAccessToken;
      } else {
        log("Token refresh failed (${response.statusCode})");
        return null;
      }
    } catch (e) {
      log("Token refresh exception: ${e.toString()}");
      return null;
    }
  }
}
