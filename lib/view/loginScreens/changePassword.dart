import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:workwista/AppTextStyle/appTextStyle.dart';
import 'package:workwista/view/loginScreens/forgotPassword.dart';

class Changepassword extends StatelessWidget {
  const Changepassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Enter new password',
              textAlign: TextAlign.center,
              style: AppTextStyle.heading,
            ),
            const SizedBox(height: 10),
            const Text(
              'Don’t miss the opportunity to easily find jobs and hire workers.',
              textAlign: TextAlign.center,
              style: AppTextStyle.loginsubhead,
            ),
            const SizedBox(height: 80),

            // Login Fields
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Password', style: AppTextStyle.labeltext),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFF757575),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const Text('Confirm Password', style: AppTextStyle.labeltext),
                const SizedBox(height: 5),
                const SizedBox(height: 5),
                SizedBox(
                  height: 50,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFFBDBDBD), // Gray border color
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFFBDBDBD), // Gray border color when not focused
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFF757575), // Slightly darker gray when focused
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Pushes login button to the bottom
            const Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(53),
                ),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {
                print("Button Pressed"); // Debugging log

                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.fade, // Left to Right transition
                //     child: const Changepassword(),
                //     childCurrent: const Forgotpassword(), // Optional: For better transition effects
                //     duration: const Duration(milliseconds: 300), // Adjust transition speed if needed
                //     reverseDuration: const Duration(milliseconds: 300),
                //   ),
                // );
              },
              child: Ink(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment(0.00, 0.50),
                    end: Alignment(1.00, 0.50),
                    colors: [Color(0xFF56A2FF), Color(0xFF00316D)],
                  ),
                  borderRadius: BorderRadius.circular(53),
                ),
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight, // Fade transition
                      child: const Forgotpassword(),
                      duration: const Duration(milliseconds: 300), // Adjust transition speed if needed
                      reverseDuration: const Duration(milliseconds: 300),
                    ),
                  );
                },
                child: const Text('Back', style: AppTextStyle.labeltext)),
          ],
        ),
      ),
    );
  }
}
