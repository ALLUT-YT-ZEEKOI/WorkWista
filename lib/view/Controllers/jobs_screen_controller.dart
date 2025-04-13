import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import 'package:workwista/view/Model/all_category_listing_model.dart';
import 'package:workwista/view/Model/all_jobs_listing_model.dart';
import 'package:workwista/view/Model/job_item_model.dart';
import 'package:workwista/view/Model/jobs_by_category_model.dart';

class JobsScreenController with ChangeNotifier {
  List<JobItem> jobsList = [];
  List<AllCategories> categoriesList = [];
  bool isloading = false;
  int selectedCategoryIndex = 0;

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
