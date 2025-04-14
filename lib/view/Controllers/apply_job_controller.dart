import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/apply_job_model.dart';

class ApplyJobController with ChangeNotifier {
  bool isloading = false;

  String? errorMessage;

  Future onApplyJob({
    required BuildContext context,
    required String Jobid,
  }) async {
    final url = Uri.parse("http://192.168.3.36:8000/job/request/take/$Jobid/");
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      final response = await http
          .post(url, headers: {"Authorization": "Bearer $accessToken"});

      if (response.statusCode == 201) {
        ApplyJobModel applyJobModel = applyJobModelFromJson(response.body);
        log("success : ${applyJobModel.message}");
      } else {
        errorMessage = "You have already requested this job";
      }
    } catch (e) {
      errorMessage = "Connection error: ${e.toString()}";
      log(e.toString());
    } finally {
      isloading = false;
      notifyListeners();

      // Show error message if exists
      if (errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    }
  }
}
