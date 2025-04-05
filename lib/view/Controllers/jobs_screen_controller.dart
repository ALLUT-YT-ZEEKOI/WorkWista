import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:workwista/view/Model/all_category_listing_model.dart';


class JobsScreenController with ChangeNotifier {
 
  List<AllCategories> categoriesList = [];
  bool isloading = false;

  Future<void> getCategories() async {
    isloading = true;
    notifyListeners();

    final url = Uri.parse("http://192.168.3.42:8000/job/view/category/");

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
      categoriesList = [];
    } finally {
      isloading = false;
      notifyListeners();
    }
  }

 

  void _handleApiError(int statusCode) {
    log("API Error: $statusCode");
    categoriesList = [];
    notifyListeners();
  }
}
