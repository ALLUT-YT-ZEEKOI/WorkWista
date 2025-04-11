import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/job_details_model.dart';
class JobDetailsScreenController with ChangeNotifier {
  JobDetailsModel? jobDetails;
  bool isloading = false;
  String? errorMessage; // Add error message tracking

  Future<void> getJobDetails(String jobId) async {
    isloading = true;
    notifyListeners();

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String access_token = prefs.getString("access") ?? "";

      final url = Uri.parse('http://192.168.3.36:8000/job/view/detail_job/$jobId/');
      
      log("Requesting job details with token: $access_token"); // Debug log
      
      final response = await http.get(
        url, 
        headers: {"Authorization": "Bearer $access_token"}
      );

      log("Response status: ${response.statusCode}"); // Debug log
      log("Response body: ${response.body}"); // Debug log

      if (response.statusCode == 200) { // Changed from 600 to 200
        jobDetails = jobDetailsModelFromJson(response.body);
        log("Successfully parsed job details: ${jobDetails?.toJson()}"); // Debug log
      } else {
        errorMessage = "API Error (${response.statusCode})";
        log(errorMessage!);
        _handleApiError(response.statusCode, response.body);
      }
    } catch (e) {
      errorMessage = "Network Error: ${e.toString()}";
      log(errorMessage!);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void _handleApiError(int statusCode, String responseBody) {
    log("API Error $statusCode: $responseBody");
    // You could parse error messages from responseBody here
  }
}