import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/responsive_helper.dart';

class SearchField extends StatelessWidget {
  final double height;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? hintText;

  const SearchField({
    required this.height,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.hintText = "Search",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ResponsiveHelper.height(height, context),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          helperStyle: TextStyle(),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: ColorConstants.containerBorder
                  // ignore: deprecated_member_use
                  .withOpacity(0.9), // adjust opacity
              width: 2, // border width
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.w),
            borderSide: BorderSide(
              // ignore: deprecated_member_use
              color: ColorConstants.containerBorder.withOpacity(0.1),
            ),
          ),
        ),
      ),
    );
  }
}
