import 'package:flutter/material.dart';
import 'package:workwista/view/Wdigets/jobofferscard.dart';
import 'package:workwista/view/responsive_helper.dart';

class SelectedCategoryJobsScreen extends StatelessWidget {
  String selectedCategory;
  SelectedCategoryJobsScreen({super.key, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        title: Text(selectedCategory),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.width(10, context), vertical: 24),
          child: Column(
            children: [
              JobOffersCard(
                numOfcards: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
