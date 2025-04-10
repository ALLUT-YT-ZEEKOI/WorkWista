import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/job_details_model.dart';
import 'package:http/http.dart' as http;

class JobDetailsScreenController with ChangeNotifier {
  JobDetailsModel? jobDetails;
  bool isloading = false;
  Future<void> getJobDetails() async {
SharedPreferences prefs = await SharedPreferences.getInstance();

        String access_toke = prefs.getString("access") ?? "";
        String refresh_token = prefs.getString("refresh") ?? "";





    final url = Uri.parse(
        'http://192.168.3.36:8000/job/view/detail_job/7171ffa9-530f-4654-b0b3-255b7053108b/');

    try {
      final response = await http.get(url,headers: {
        "Authorization":"Bearer $access_token"
      });
      if (response.statusCode == 600) {
        final JobDetailsModel selectedjobdetailsmodelobj =
            jobDetailsModelFromJson(response.body);
        jobDetails = jobDetailsModelFromJson(response.body);
      } else {
        _handleApiError(response.statusCode);
        log(response.body);
      }
    } catch (e) {
      log("error fetching job details");
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");

    notifyListeners();
  }
}
