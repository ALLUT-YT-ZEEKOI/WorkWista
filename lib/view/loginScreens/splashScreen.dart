import 'package:flutter/material.dart';
import 'package:workwista/AppTextStyle/appTextStyle.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'assets/Workwista (1).png',
              width: screenWidth * 0.3,
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Workwista 👋',
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

            // Google Sign-in Button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/flat-color-icons_google.png',
                    width: screenWidth * 0.08,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Sign up with Google',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.normalFont,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // OR Divider
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Divider(color: Color(0xFFCED7DE), thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('or', style: AppTextStyle.loginsubhead),
                ),
                Expanded(child: Divider(color: Color(0xFFCED7DE), thickness: 1)),
              ],
            ),
            const SizedBox(height: 20),

            // Login Fields
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Phone Number/Email', style: AppTextStyle.labeltext),
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
                const SizedBox(height: 20),
                const Text('Password', style: AppTextStyle.labeltext),
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
            const SizedBox(
              width: 372,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 340,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Dont have and account ? ', style: AppTextStyle.loginsubhead),
                          TextSpan(
                            text: 'Sign up now',
                            style: TextStyle(
                              color: Color(0xFF1E83FF),
                              fontSize: 12,
                              fontFamily: 'Mona Sans',
                              fontWeight: FontWeight.w500,
                              height: 1.33,
                              letterSpacing: 0.04,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            // Login Button
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
                // Add your onPressed logic here
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
                    'Login',
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
          ],
        ),
      ),
    );
  }
}
