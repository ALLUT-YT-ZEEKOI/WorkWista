import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workwista/view/Model/all_category_listing_model.dart';
import 'package:workwista/view/Model/all_jobs_listing_model.dart';
import 'package:workwista/view/Model/job_item_model.dart';
import 'package:workwista/view/Model/job_requests_model.dart';
import 'package:workwista/view/Model/jobs_by_category_model.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';

class JobsScreenController with ChangeNotifier {
  List<JobItem> jobsList = [];
  List<AllCategories> categoriesList = [];
  bool isloading = false;
  int selectedCategoryIndex = 0;
  List<PostedItem> postedJobsList = []; // List for posted jobs
  String? errorMessage;
    JobRequestsModel? jobRequests;
 


Future<void> respondToRequest(String requestId, String action) async {
  isloading = true;
  notifyListeners();

  try {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access") ?? "";
    final url = Uri.parse("http://192.168.3.36:8000/job/manage/applicant/$requestId/");

    Map<String, String> headers = {
      "Authorization": "Bearer $accessToken",
      "Content-Type": "application/json",
    };

    Map<String, String> body = {
      "action": action, // "accept" or "decline"
    };

    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      final refreshToken = prefs.getString("refresh") ?? "";
      final newAccessToken = await _refreshToken(refreshToken);
      if (newAccessToken != null) {
        headers["Authorization"] = "Bearer $newAccessToken";
        response = await http.post(
          url,
          headers: headers,
          body: jsonEncode(body),
        );
      }
    }

    if (response.statusCode == 200) {
      await getPostedJobs();
    } else {
      errorMessage = "Failed to $action request: ${response.statusCode}";
      _handleApiError(response.statusCode);
    }
  } catch (e) {
    errorMessage = "Error on $action request: ${e.toString()}";
    log(errorMessage!);
  } finally {
    isloading = false;
    notifyListeners();
  }
}


    // Fetch job requests for a specific job
  Future<void> getJobRequests(String jobId) async {  // Accept jobId as parameter
    isloading = true;
    notifyListeners();

    final url = Uri.parse("http://192.168.3.36:8000/job/view/applicant/$jobId/");

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      
      // First attempt with current access token
      var response = await http.get(
        url,
        headers: {"Authorization": "Bearer $accessToken"},
      );

      // If unauthorized (401), try refreshing token
      if (response.statusCode == 401) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          response = await http.get(
            url,
            headers: {"Authorization": "Bearer $newAccessToken"},
          );
        }
      }

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        jobRequests = JobRequestsModel.fromJson(jsonData);
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching job requests: $e");
    } finally {
      isloading = false;
      notifyListeners();
    }
  }


   // Helper method for authenticated requests
  Future<http.Response> _makeAuthenticatedRequest(Uri url, String accessToken) async {
    return await http.get(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
    );
  }

 Future<void> getPostedJobs() async {
    isloading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      
      // First attempt with current access token
      var response = await _makePostedJobsRequest(accessToken);

      // If unauthorized (401), try refreshing token
      if (response.statusCode == 401) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";
        
        // Refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          // Retry with new token
          response = await _makePostedJobsRequest(newAccessToken);
        }
      }
      
      // Process final response
      if (response.statusCode == 200) {
        final PostedJobsModel postedJobsModel = postedJobsModelFromJson(response.body);
        postedJobsList = postedJobsModel.data ?? [];
        log("Successfully loaded posted jobs");
      } else {
        errorMessage = "Failed to load posted jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error fetching posted jobs: ${e.toString()}";
      log(errorMessage!);
      postedJobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _makePostedJobsRequest(String accessToken) async {
    final url = Uri.parse("http://192.168.3.36:8000/job/list/user/postedjob/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final url = Uri.parse('http://192.168.3.36:8000/users/api/token/refresh/');
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

// Add this to your JobsScreenController
  Future<void> searchJobs(String query) async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("http://192.168.3.36:8000/job/view/joblist/?title=$query");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllJobModel jobModel = allJobModelFromJson(response.body);
        jobsList = jobModel.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error searching jobs: $e");
      jobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getJobsByCategory(String categoryId) async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("http://192.168.3.36:8000/job/category/job/$categoryId/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final JobsByCategoryModel jobsByCategoryModel =
            jobsByCategoryModelFromJson(response.body);
        jobsList = jobsByCategoryModel.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching jobs by category: $e");
      jobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void onCategorySelected(int index) {
    selectedCategoryIndex = index;
    notifyListeners();

    if (index == 0) {
      // If "All" is selected, fetch all jobs
      getJobs();
    } else {
      // For specific categories, fetch jobs by category
      final selectedCatId = categoriesList[index - 1].id.toString();
      getJobsByCategory(selectedCatId);
    }
  }

  Future<void> getCategories() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("http://192.168.3.36:8000/job/view/category/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllCategoryListingModel allcatmodelobj =
            allCategoryListingModelFromJson(response.body);
        categoriesList = allcatmodelobj.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching categories: $e");
      jobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getJobs() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("http://192.168.3.36:8000/job/view/joblist/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllJobModel jobModel = allJobModelFromJson(response.body);
        jobsList = jobModel.data ?? []; // update jobsList to List<Datum>
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching jobs: $e");
      jobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");
    jobsList = [];
    notifyListeners();
  }
}
