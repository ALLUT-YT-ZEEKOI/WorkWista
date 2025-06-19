import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';

class LottieDialog extends StatefulWidget {
  const LottieDialog({super.key});

  @override
  State<LottieDialog> createState() => _LottieDialogState();
}

class _LottieDialogState extends State<LottieDialog>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/account_created.json',
            controller: _controller,
            repeat: false,
            fit: BoxFit.contain,
            height: 180,
            width: double.infinity,
            onLoaded: (composition) {
              _controller = AnimationController(
                vsync: this,
                duration: composition.duration,
              );

              _controller!.addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  Navigator.of(context).pop(); // Close dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomBottomNavbar()),
                  );
                }
              });

              _controller!.forward();
              setState(() {}); // update widget with controller
            },
          ),
        ],
      ),
    );
  }
}
