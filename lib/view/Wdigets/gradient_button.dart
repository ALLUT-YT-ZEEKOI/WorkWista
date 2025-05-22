import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class GradientButton extends StatelessWidget {
  String name;
  double height;
  double width;
  double radius;
  void Function()? onPressed;
  GradientButton({
    this.radius = 53,
    required this.name,
    required this.onPressed,
    required this.height,
    required this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(
          width,
          height,
        )),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(53.r), // Adjust as needed
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF56A2FF), // Light blue (#56A2FF) on left
              Color(0xFF00316D), // Dark blue (#00316D) on right
            ],
            begin: Alignment.centerLeft, // Gradient starts from left
            end: Alignment.centerRight,
          ),
          borderRadius:
              BorderRadius.circular(radius), // Match button's border radius
        ),
        child: Container(
          width: 373.w,
          height: 44.h,
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
