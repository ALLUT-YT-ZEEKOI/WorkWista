

import 'package:flutter/material.dart';
import 'package:workwista/view/responsive_helper.dart';

class GradientButton extends StatelessWidget {
  String name;
  double height;
  double width;
  void Function()? onPressed;
  GradientButton({
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
          ResponsiveHelper.width(width, context),
          ResponsiveHelper.height(height, context),
        )),
        backgroundColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(53), // Adjust as needed
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
      onPressed:onPressed,
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
              BorderRadius.circular(53), // Match button's border radius
        ),
        child: Container(
          width: ResponsiveHelper.width(373, context),
          height: ResponsiveHelper.height(44, context),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
