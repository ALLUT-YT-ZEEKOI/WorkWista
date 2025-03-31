import 'package:flutter/material.dart';

class ResponsiveHelper {
  // Designer's reference dimensions (iPhone 15 Pro: 393x852)
  static const double _designWidth = 393.0;
  static const double _designHeight = 852.0;

  // Get responsive width (based on design width)
  static double width(double px, BuildContext context) {
    return px * (MediaQuery.of(context).size.width / _designWidth);
  }

  // Get responsive height (based on design height)
  static double height(double px, BuildContext context) {
    return px * (MediaQuery.of(context).size.height / _designHeight);
  }

  // Get responsive font size (scales with width)
  static double fontSize(double px, BuildContext context) {
    return width(px, context);
  }

  // Get responsive padding/margins (scales with width)
  static EdgeInsets padding({
    required double left,
    required double right,
    required double top,
    required double bottom,
    required BuildContext context,
  }) {
    return EdgeInsets.fromLTRB(
      width(left, context),
      height(top, context),
      width(right, context),
      height(bottom, context),
    );
  }
}