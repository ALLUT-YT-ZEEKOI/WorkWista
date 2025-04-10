import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:workwista/view/Model/job_offers_card_details_model.dart';

class JobOffersCardController with ChangeNotifier {
  List<JobOfferCardDetails> JobOffersCardDetailsList = [];

  bool isloading = false;

  Future<void> getJobOffersCardDetails() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("http://192.168.3.36:8000/job/view/joblist/");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final JobOfferCardDetailsModel alljobofferslistmodelobj =
            jobOfferCardDetailsModelFromJson(response.body);

        JobOffersCardDetailsList = alljobofferslistmodelobj.data ?? [];
      } else {
        _handleApiError(response.statusCode);
      }
    } catch (e) {
      log("Error fetching jobs: $e");
      JobOffersCardDetailsList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");
    JobOffersCardDetailsList = [];
    notifyListeners();
  }
}
