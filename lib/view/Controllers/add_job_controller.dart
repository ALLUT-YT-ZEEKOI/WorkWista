import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/add_job_model.dart';

class AddJobController with ChangeNotifier {
  bool islaoding = false;
  String? errorMessage;

  Future onAddJob({
    required String title,
    required String description,
    required String manual_location,
    required String key_responsibility,
    required String job_date,
    required BuildContext context,
    required File? job_image,
    required String salary_from,
    required String salary_to,
    required String? job_category,
    required String job_type,
  }) async {
    islaoding = true;
    errorMessage = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access") ?? "";
    String refreshToken = prefs.getString("refresh") ?? "";

    try {
      var response = await _makeJobPostRequest(
        accessToken,
        title,
        description,
        job_date,
        job_image,
        salary_from,
        salary_to,
        manual_location,
        key_responsibility,
        job_category,
        job_type,
      );

      if (response.statusCode == 401) {
        log("Access token expired, refreshing...");
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          response = await _makeJobPostRequest(
            newAccessToken,
            title,
            description,
            job_date,
            job_image,
            salary_from,
            salary_to,
            manual_location,
           key_responsibility,
           job_category,
           job_type
          );
        }
      }

      if (response.statusCode == 201) {
        AddJobModel addJobModel = addJobModelFromJson(response.body);
        log("Job posted successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("posted!")),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => CustomBottomNavbar()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
        log(addJobModel.message.toString());
      } else {
        errorMessage = "Failed to post job (${response.statusCode})";
        log(response.body);
      }
    } catch (e) {
      errorMessage = "Connection error: ${e.toString()}";
      log(errorMessage!);
    } finally {
      islaoding = false;
      notifyListeners();
      if (errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    }
  }

  Future<http.Response> _makeJobPostRequest(
    String token,
    String title,
    String description,
    String job_date,
    File? job_image,
    String salary_from,
    String salary_to,
    String manual_location,
    String key_responsibility,
    String? job_category,
    String job_type,
  ) async {
    final url = Uri.parse("https://workwista.com/job/create/");
    var request = http.MultipartRequest('POST', url);

    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['job_date'] = job_date;
    request.fields['salary_from'] = salary_from;
    request.fields['salary_to'] = salary_to;
    request.fields['manual_location'] = manual_location;
    request.fields['key_responsibility'] = key_responsibility;
    request.fields['job_category'] = job_category ?? '';
    request.fields['job_type'] = job_type;

    if (job_image != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'job_image',
        job_image.path,
      ));
    }

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
