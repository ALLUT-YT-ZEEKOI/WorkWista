import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/responsive_helper.dart';

class ButtonWithoutGradient extends StatelessWidget {
  String name;
  ButtonWithoutGradient({
    required this.name,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            minimumSize: WidgetStatePropertyAll(Size(
                ResponsiveHelper.width(373, context),
                ResponsiveHelper.height(44, context)))),
        onPressed: () {
          log("pressed");
        },
        child: Text(
          name,
          style: TextStyle(
              color: ColorConstants.viewMoreText,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ));
  }
}
