
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workwista/Utils/color_constants.dart';

// ignore: must_be_immutable
class ButtonWithoutGradient extends StatelessWidget {
  String name;
  ButtonWithoutGradient({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      width: 373.w,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Center(
        child: Text(
          "Back",
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: ColorConstants.viewMoreText),
        ),
      ),
    );
  }
}
