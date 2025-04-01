import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/responsive_helper.dart';

// ignore: must_be_immutable
class searchField extends StatelessWidget {
  double height;
   searchField({
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.height(height, context),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Search...",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: ColorConstants.containerBorder.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }
}