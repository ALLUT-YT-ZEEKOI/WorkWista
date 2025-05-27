// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workwista/view/Model/my_jobs_model.dart';


// class MyJobsScreenController with ChangeNotifier {
//   MyJobsModel? myJobs;
//   bool isloading = false;
//   String? errorMessage;

//   Future<void> getMyJobs() async {
//     isloading = true;
//     notifyListeners();

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       String accessToken = prefs.getString("access") ?? "";

//       // First attempt with current access token
//       var response = await _makeMyJobsRequest(accessToken);

//       // If unauthorized (401), try refreshing token
//       if (response.statusCode == 401) {
//         log("Access token expired, attempting refresh...");
//         final refreshToken = prefs.getString("refresh") ?? "";

//         // Refresh the token
//         final newAccessToken = await _refreshToken(refreshToken);
//         if (newAccessToken != null) {
//           // Retry with new token
//           response = await _makeMyJobsRequest(newAccessToken);
//         }
//       }

//       // Process final response
//       if (response.statusCode == 200) {
//         myJobs = myJobsModelFromJson(response.body);
//         log(response.body);
//         log("Successfully loaded my jobs");
//         log("As Jobber jobs count: ${myJobs!.asJobber?.length ?? 0}");
//         log("As Recruiter jobs count: ${myJobs!.asRecruter?.length ?? 0}");
//       } else {
//         errorMessage = "Failed to load my jobs (${response.statusCode})";
//         _handleApiError(response.statusCode, response.body);
//       }
//     } catch (e) {
//       errorMessage = "Error: ${e.toString()}";
//       log(errorMessage!);
//     } finally {
//       isloading = false;
//       notifyListeners();
//     }
//   }

//   Future<http.Response> _makeMyJobsRequest(String accessToken) async {
//     final url = Uri.parse('https://workwista.com/job/showcard/'); // Update with actual endpoint
//     return await http.get(
//       url,
//       headers: {"Authorization": "Bearer $accessToken"},
//     );
//   }

//   Future<String?> _refreshToken(String refreshToken) async {
//     try {
//       final url = Uri.parse('https://workwista.com/users/api/token/refresh/');
//       final response = await http.post(
//         url,
//         body: {'refresh': refreshToken},
//       );

//       if (response.statusCode == 200) {
//         final newTokens = jsonDecode(response.body);
//         final newAccessToken = newTokens['access'];

//         // Save new access token
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString("access", newAccessToken);

//         log("Successfully refreshed access token");
//         return newAccessToken;
//       } else {
//         log("Failed to refresh token: ${response.statusCode}");
//         errorMessage = "Session expired. Please login again.";
//         // Optionally: Clear tokens and navigate to login
//         // await prefs.remove("access");
//         // await prefs.remove("refresh");
//         return null;
//       }
//     } catch (e) {
//       log("Token refresh error: ${e.toString()}");
//       return null;
//     }
//   }

//   void _handleApiError(int statusCode, String responseBody) {
//     log("API Error $statusCode: $responseBody");
//     // Additional error handling if needed
//   }

//   // Helper methods to get specific job lists
//   List<JobList> get asJobberJobs => myJobs?.asJobber ?? [];
//   List<JobList> get asRecruiterJobs => myJobs?.asRecruter ?? [];
  
//   // Helper methods to check if lists are empty
//   bool get hasJobberJobs => asJobberJobs.isNotEmpty;
//   bool get hasRecruiterJobs => asRecruiterJobs.isNotEmpty;
//   bool get hasAnyJobs => hasJobberJobs || hasRecruiterJobs;
  
//   // Helper method to get total jobs count
//   int get totalJobsCount => asJobberJobs.length + asRecruiterJobs.length;
// }