import 'package:flutter/material.dart';

class AppUtils {
  static showSnackbar(
      {required BuildContext context,
      required String message,
      Color bgcolor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: bgcolor, content: Text(message)));
  }
}
