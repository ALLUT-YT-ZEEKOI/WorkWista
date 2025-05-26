import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/Utils/app_utils.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/Model/apply_job_model.dart';

class ApplyJobController with ChangeNotifier {
  bool isloading = false;

  String? errorMessage;

  Future onApplyJob({
    required BuildContext context,
    required String Jobid,
  }) async {
    final url = Uri.parse("https://workwista.com/job/request/take/$Jobid/");
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => CustomBottomNavbar(
              successMessage: "Job request sent successfully",
            ),
          ),
          (Route<dynamic> route) => false,
        );
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
        AppUtils.showSnackbar(
            context: context,
            message: errorMessage.toString(),
            bgcolor: Colors.red);
      
      }
    }
  }
}
