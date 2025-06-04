import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workwista/view/Model/my_jobs_completed_jobs_model.dart';
import 'package:workwista/view/Model/my_jobs_pending_jobs_model.dart';
import 'package:workwista/view/Model/my_jobs_posted_jobs_model.dart';
import 'package:workwista/view/Model/my_jobs_rejected_jobs_model.dart';

class MyJobsScreenController with ChangeNotifier {
  List<MyJobsPostedItem> myJobspostedJobsList = [];
  List<MyJobsRejectedItem> myJobsrejectedJobsList = [];
  List<MyJobsPendingItem> myJobspendingJobsList = [];
  List<MyJobsCompletedItem> myJobscompletedJobsList = [];
  bool isloading = false;
  String? errorMessage;

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

        // Save new access token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("access", newAccessToken);

        log("Successfully refreshed access token");
        return newAccessToken;
      } else {
        log("Failed to refresh token: ${response.statusCode}");
        errorMessage = "Session expired. Please login again.";
        return null;
      }
    } catch (e) {
      log("Token refresh error: ${e.toString()}");
      return null;
    }
  }

Future<void> getMyJobsCompletedJobs() async {
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access') ?? "";

      //first attepmt with current acces token

      var response = await _makeMyJobsCompletedJobsRequest(accessToken);

      //if unauthorized --- refresh the token
      if (response.statusCode == 400) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        //refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          //retry with new access token
          response = await _makeMyJobsCompletedJobsRequest(newAccessToken);
        }
      }

      //process the final response

      if (response.statusCode == 200) {
        final MyJobsCompletedJobsModel myJobsCompletedJobsModel =
            myJobsCompletedJobsModelFromJson(response.body);
        myJobscompletedJobsList = myJobsCompletedJobsModel.data ?? [];
        log("Successfully loaded myjobs-completed jobs");
      } else {
        errorMessage =
            "Failed to load myjobs-completed jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error fetching myJobs-completed jobs : ${e.toString()}";
      log(errorMessage!);
      myJobscompletedJobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

 Future<http.Response> _makeMyJobsCompletedJobsRequest(
      String accessToken) async {
    final url = Uri.parse("https://workwista.com/job/view/completed-jobs/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }



Future<void> getMyJobsPendingJobs() async {
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access') ?? "";

      //first attepmt with current acces token

      var response = await _makeMyJobsPendingJobsRequest(accessToken);

      //if unauthorized --- refresh the token
      if (response.statusCode == 400) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        //refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          //retry with new access token
          response = await _makeMyJobsPendingJobsRequest(newAccessToken);
        }
      }

      //process the final response

      if (response.statusCode == 200) {
        final MyJobsPendingJobsModel myJobsPendingJobsModel =
            myJobsPendingJobsModelFromJson(response.body);
        myJobspendingJobsList = myJobsPendingJobsModel.data ?? [];
        log("Successfully loaded myjobs-pending jobs");
      } else {
        errorMessage =
            "Failed to load myjobs-pending jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error fetching myJobs-pending jobs : ${e.toString()}";
      log(errorMessage!);
      myJobspendingJobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

 Future<http.Response> _makeMyJobsPendingJobsRequest(
      String accessToken) async {
    final url = Uri.parse("https://workwista.com/job/view/pending-jobs/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }



  Future<void> getMyJobsRejectedJobs() async {
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access') ?? "";

      //first attepmt with current acces token

      var response = await _makeMyJobsRejectedJobsRequest(accessToken);

      //if unauthorized --- refresh the token
      if (response.statusCode == 400) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        //refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          //retry with new access token
          response = await _makeMyJobsRejectedJobsRequest(newAccessToken);
        }
      }

      //process the final response

      if (response.statusCode == 200) {
        final MyJobsRejectedJobsModel myJobsRejectedJobsModel =
            myJobsRejectedJobsModelFromJson(response.body);
        myJobsrejectedJobsList = myJobsRejectedJobsModel.data ?? [];
        log("Successfully loaded myjobs-rejected jobs");
      } else {
        errorMessage =
            "Failed to load myjobs-rejected jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error fetching myJobs-rejected jobs : ${e.toString()}";
      log(errorMessage!);
      myJobsrejectedJobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _makeMyJobsRejectedJobsRequest(
      String accessToken) async {
    final url = Uri.parse("https://workwista.com/job/view/rejected-jobs/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<void> getMyJobsPostedJobs() async {
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString('access') ?? "";

      //first attepmt with current acces token

      var response = await _makeMyJobsPostedJobsRequest(accessToken);

      //if unauthorized --- refresh the token
      if (response.statusCode == 400) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        //refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          //retry with new access token
          response = await _makeMyJobsPostedJobsRequest(newAccessToken);
        }
      }

      //process the final response

      if (response.statusCode == 200) {
        final MyJobsPostedJobsModel myJobsPostedJobsModel =
            myJobsPostedJobsModelFromJson(response.body);
        myJobspostedJobsList = myJobsPostedJobsModel.data ?? [];
        log("Successfully loaded myjobs-posted jobs");
        log(myJobspostedJobsList.toString());
      } else {
        errorMessage =
            "Failed to load myjobs-posted jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error fetching myJobs-posted jobs : ${e.toString()}";
      log(errorMessage!);
      myJobspostedJobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _makeMyJobsPostedJobsRequest(String accessToken) async {
    final url = Uri.parse("https://workwista.com/job/view/posted-jobs/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");
    myJobspostedJobsList = [];
    notifyListeners();
  }
}
