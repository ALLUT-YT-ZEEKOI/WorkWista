import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workwista/view/Model/all_category_listing_model.dart';
import 'package:workwista/view/Model/all_jobs_listing_model.dart';
import 'package:workwista/view/Model/job_completion_model.dart';
import 'package:workwista/view/Model/job_item_model.dart';
import 'package:workwista/view/Model/job_requests_model.dart';
import 'package:workwista/view/Model/job_types_model.dart';
import 'package:workwista/view/Model/jobs_by_category_model.dart';
import 'package:workwista/view/Model/my_jobs_model.dart';
import 'package:workwista/view/Model/posted_jobs_model.dart';

class JobsScreenController with ChangeNotifier {
  List<JobItem> jobsList = [];
  List<JobItem> SjobsList = [];
  List<AllCategories> SCategoryList = [];
  List<AllCategories> categoriesList = [];
  List<AllJobTypes> jobtypeslist = [];
  bool isloading = false;
  int selectedCategoryIndex = 0;
  List<PostedItem> postedJobsList = []; // List for posted jobs
  String? errorMessage;
  JobRequestsModel? jobRequests;
  List<AllCategories> filteredCategories = [];
  MyJobsModel? myJobs;

  JobCompletionModel? completedJob;
  bool isCompletingJob = false;

  Future<bool> completeJob(String? jobId) async {
    isCompletingJob = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";

      var response = await _makeCompleteJobRequest(jobId, accessToken);

      if (response.statusCode == 401) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          response = await _makeCompleteJobRequest(jobId, newAccessToken);
        }
      }

      if (response.statusCode == 200) {
        completedJob = jobCompletionModelFromJson(response.body);
        await getMyJobs();
        return true;
      } else {
        errorMessage = "Failed to complete job (${response.statusCode})";
        _handleApiError(response.statusCode);
        return false;
      }
    } catch (e) {
      errorMessage = "Error completing job: ${e.toString()}";
      log(errorMessage!);
      return false;
    } finally {
      isCompletingJob = false;
      notifyListeners();
    }
  }

  Future<http.Response> _makeCompleteJobRequest(
      String? jobId, String accessToken) async {
    final url = Uri.parse('https://workwista.com/job/complete/$jobId/');

    // Prepare the body data
    Map<String, dynamic> body = {
      "is_completed": true,
    };

    return await http.post(
      url,
      headers: {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      },
      body: jsonEncode(body),
    );
  }

  String getJobButtonText(JobList jobList) {
    final now = DateTime.now();

    // Handle null job_date case
    if (jobList.job!.jobDate == null) {
      return "No Date Set";
    }

    // Format dates for comparison (ignoring time)
    final currentDate = DateTime(now.year, now.month, now.day);
    final jobDate = jobList.job!.jobDate;
    final jobStartDate = DateTime(jobDate!.year, jobDate.month, jobDate.day);

    // Debug log to see the dates being compared
    debugPrint("Current: ${DateFormat('yyyy-MM-dd').format(currentDate)}");
    debugPrint("Job: ${DateFormat('yyyy-MM-dd').format(jobStartDate)}");

    if (currentDate.isBefore(jobStartDate)) {
      return "Job Not Started (${DateFormat('yyyy-MM-dd').format(jobStartDate)})";
    }

    // If today is the job date, and user is jobber → "Finish"
    if (currentDate == jobStartDate && (jobList.isUserJobber ?? false)) {
      return "Finish (Today)";
    }

    // Existing logic for after the job date
    if (jobList.isUserJobber ?? false) {
      return (jobList.isCompleted ?? false)
          ? (jobList.isPaid ?? false ? "Paid" : "Waiting for Payment")
          : "Finish (${DateFormat('yyyy-MM-dd').format(jobStartDate)})";
    } else {
      return (jobList.isCompleted ?? false)
          ? (jobList.isPaid ?? false ? "Paid" : "Pay")
          : "Waiting for completion (${DateFormat('yyyy-MM-dd').format(jobStartDate)})";
    }
  }

  bool isJobButtonEnabled(JobList jobList) {
    final now = DateTime.now();

    // Handle null job_date case
    if (jobList.job!.jobDate == null) {
      return false; // Disable if no date is set
    }

    // Format dates for comparison (ignoring time)
    final currentDate = DateTime(now.year, now.month, now.day);
    final jobDate = jobList.job!.jobDate;
    final jobStartDate = DateTime(jobDate!.year, jobDate.month, jobDate.day);

    // Debug log to see the dates being compared
    debugPrint("Current: ${DateFormat('yyyy-MM-dd').format(currentDate)}");
    debugPrint("Job: ${DateFormat('yyyy-MM-dd').format(jobStartDate)}");

    if (currentDate.isBefore(jobStartDate)) {
      return false; // Disable if job hasn't started
    }

    // Enable if it's the job date and user is jobber
    if (currentDate == jobStartDate && (jobList.isUserJobber ?? false)) {
      return true;
    }

    // Existing logic for after job date
    if (jobList.isUserJobber ?? false) {
      return !(jobList.isCompleted ?? false); // Enable if job is not completed
    } else {
      return (jobList.isCompleted ?? false) &&
          !(jobList.isPaid ?? false); // Enable if completed but unpaid
    }
  }

  // Clear completion data when needed
  void clearCompletionData() {
    completedJob = null;
    notifyListeners();
  }

  Future<void> getMyJobs() async {
    isloading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";

      // First attempt with current access token
      var response = await _makeMyJobsRequest(accessToken);

      // If unauthorized (401), try refreshing token
      if (response.statusCode == 401) {
        log("Access token expired, attempting refresh...");
        final refreshToken = prefs.getString("refresh") ?? "";

        // Refresh the token
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          // Retry with new token
          response = await _makeMyJobsRequest(newAccessToken);
        }
      }

      // Process final response
      if (response.statusCode == 200) {
        myJobs = myJobsModelFromJson(response.body);
        log(response.body);
        log("Successfully loaded my jobs");
        log("As Jobber jobs count: ${myJobs!.asJobber?.length ?? 0}");
        log("As Recruiter jobs count: ${myJobs!.asRecruter?.length ?? 0}");
      } else {
        errorMessage = "Failed to load my jobs (${response.statusCode})";
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      errorMessage = "Error: ${e.toString()}";
      log(errorMessage!);
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<http.Response> _makeMyJobsRequest(String accessToken) async {
    final url = Uri.parse(
        'https://workwista.com/job/showcard/'); // Update with actual endpoint
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  // Helper methods to get specific job lists
  List<JobList> get asJobberJobs => myJobs?.asJobber ?? [];
  List<JobList> get asRecruiterJobs => myJobs?.asRecruter ?? [];

  CompletedJobData? get completedJobData => completedJob?.data;
  // Helper methods to check if lists are empty
  bool get hasJobberJobs => asJobberJobs.isNotEmpty;
  bool get hasRecruiterJobs => asRecruiterJobs.isNotEmpty;
  bool get hasAnyJobs => hasJobberJobs || hasRecruiterJobs;

  // Helper method to get total jobs count
  int get totalJobsCount => asJobberJobs.length + asRecruiterJobs.length;

  void filterCategories(String query) {
    if (query.isEmpty) {
      filteredCategories = categoriesList;
    } else {
      filteredCategories = categoriesList
          .where((cat) =>
              cat.title?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
    notifyListeners();
  }

  Future<bool> closeJob(String jobId) async {
    isloading = true;

    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      final url = Uri.parse('https://workwista.com/job/close-job/$jobId/');

      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      };
      var response = await http.post(url, headers: headers);

      if (response.statusCode == 401) {
        final refreshToken = prefs.getString("refresh") ?? "";
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          headers["Authorization"] = "Bearer $newAccessToken";
          response = await http.post(url, headers: headers);
        }
      }
      if (response.statusCode == 200) {
        log("Job closed successfully");
        return true;
      } else {
        errorMessage = "Failed to close the job ${response.statusCode}";
        log(response.statusCode.toString());
        _handleApiError(response.statusCode);
        return false;
      }
    } catch (e) {
      errorMessage = "Error on job closing : ${e.toString()}";
      log(errorMessage!);
      log(e.toString());
      return false;
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteJob(String jobId) async {
    isloading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      final url = Uri.parse('https://workwista.com/job/delete/$jobId/');

      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken",
        "Content-Type": "application/json",
      };

      var response = await http.post(url, headers: headers);

      if (response.statusCode == 401) {
        final refreshToken = prefs.getString("refresh") ?? "";
        final newAccessToken = await _refreshToken(refreshToken);
        if (newAccessToken != null) {
          headers["Authorization"] = "Bearer $newAccessToken";
          response = await http.post(url, headers: headers);
        }
      }
      if (response.statusCode == 403) {
        log("This job is ongoing and cannot be deleted. Please close it instead.");
        return false;
      }
      if (response.statusCode == 200) {
        log("Job deleted successfully");
        return true;
      } else {
        errorMessage = "Failed to delete the job ${response.statusCode}";
        _handleApiError(response.statusCode);
        return false;
      }
    } catch (e) {
      errorMessage = "Error on job deletion : ${e.toString()}";
      log(errorMessage!);
      return false;
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> respondToRequest(String requestId, String action) async {
    isloading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      String accessToken = prefs.getString("access") ?? "";
      final url =
          Uri.parse("https://workwista.com/job/manage/applicant/$requestId/");

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
  Future<void> getJobRequests(String jobId) async {
    // Accept jobId as parameter
    isloading = true;
    notifyListeners();

    final url = Uri.parse("https://workwista.com/job/view/applicant/$jobId/");

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
  Future<http.Response> _makeAuthenticatedRequest(
      Uri url, String accessToken) async {
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
        final PostedJobsModel postedJobsModel =
            postedJobsModelFromJson(response.body);
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
    final url = Uri.parse("https://workwista.com/job/list/user/postedjob/");
    return await http.get(
      url,
      headers: {"Authorization": "Bearer $accessToken"},
    );
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

// Search job function for job search
  Future<void> searchJobs(String query) async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("https://workwista.com/job/view/joblist/?title=$query");

    try {   
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllJobModel jobModel = allJobModelFromJson(response.body);
        SjobsList = jobModel.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error searching jobs: $e");
      SjobsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

// Search job function for categorie  search
  Future<void> searchCategories(String query) async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("https://workwista.com/job/view/category/?title=$query");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllCategoryListingModel allcatmodelobj =
            allCategoryListingModelFromJson(response.body);
        SCategoryList = allcatmodelobj.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error searching Categories: $e");
      SCategoryList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getJobsByCategory(String categoryId) async {
    isloading = true;
    notifyListeners();

    final url =
        Uri.parse("https://workwista.com/job/category/job/$categoryId/");

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

  Future<void> getJobTypes() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("https://workwista.com/job/view/jobtypes/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final JobTypesModel alljobtypesmodelobj =
            jobTypesModelFromJson(response.body);
        jobtypeslist = alljobtypesmodelobj.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching categories: $e");
      jobtypeslist = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  Future<void> getCategories() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("https://workwista.com/job/view/category/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final AllCategoryListingModel allcatmodelobj =
            allCategoryListingModelFromJson(response.body);
        categoriesList = allcatmodelobj.data ?? [];
        filteredCategories = categoriesList;
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching categories: $e");
      categoriesList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

 Future<void> getJobs() async {
  isloading = true;
  errorMessage = null;
  notifyListeners();

  try {
    final prefs = await SharedPreferences.getInstance();
    String accessToken = prefs.getString("access") ?? "";

    // First attempt with current access token
    var response = await _makeJobsRequest(accessToken);

    // If unauthorized (401), try refreshing token
    if (response.statusCode == 401) {
      log("Access token expired, attempting refresh...");
      final refreshToken = prefs.getString("refresh") ?? "";

      final newAccessToken = await _refreshToken(refreshToken);
      if (newAccessToken != null) {
        response = await _makeJobsRequest(newAccessToken);
      }
    }

    // Handle response
    if (response.statusCode == 200) {
      final AllJobModel jobModel = allJobModelFromJson(response.body);
      jobsList = jobModel.data ?? [];
      log("Successfully loaded all jobs");
    } else {
      errorMessage = "Failed to load jobs (${response.statusCode})";
      _handleApiError(response.statusCode);
    }
  } catch (e) {
    errorMessage = "Error fetching jobs: ${e.toString()}";
    log(errorMessage!);
    jobsList = [];
  } finally {
    isloading = false;
    notifyListeners();
  }
}

Future<http.Response> _makeJobsRequest(String accessToken) async {
  final url = Uri.parse("https://workwista.com/job/view/joblist/");
  return await http.get(
    url,
    headers: {"Authorization": "Bearer $accessToken"},
  );
}

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");
    jobsList = [];
    notifyListeners();
  }
}
