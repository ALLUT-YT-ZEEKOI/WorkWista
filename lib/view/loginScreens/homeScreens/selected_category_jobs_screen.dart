import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/responsive_helper.dart';

class SelectedCategoryJobsScreen extends StatelessWidget {
  final String selectedCategory;
  final String? categoryId;
  
  SelectedCategoryJobsScreen({
    super.key, 
    required this.selectedCategory,
    this.categoryId
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<JobsScreenController>(context, listen: false);
    
    // Fetch jobs for this category when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (categoryId != null) {
        controller.getJobsByCategory(categoryId!);
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        title: Text(selectedCategory),
      ),
      body: Consumer<JobsScreenController>(
        builder: (context, controller, child) {
          if (controller.isloading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (controller.jobsList.isEmpty) {
            return const Center(child: Text("No jobs available for this category"));
          }
          
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveHelper.width(10, context), 
                  vertical: 24),
              child: Column(
                children: [
                  ...controller.jobsList.map((jobItem) => JobOffersCard(
                    jobItem: jobItem,
                  )).toList(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}