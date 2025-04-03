import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:workwista/AppTextStyle/app_text_style.dart';
import 'package:workwista/view/loginScreens/sign_in_screen.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
              const Text(
                'Sign up for an account now!',
                textAlign: TextAlign.center,
                style: AppTextStyle.heading,
              ),
              const SizedBox(height: 10),
              const Text(
                'Join us for job opportunities!',
                textAlign: TextAlign.center,
                style: AppTextStyle.loginsubhead,
              ),
              const SizedBox(height: 40),

              // Form Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your name', style: AppTextStyle.labeltext),
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Date of Birth', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Day",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 1,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Month",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 1,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Year",
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(33),
                                borderSide: const BorderSide(
                                  color: Color(0xFFBDBDBD),
                                  width: 1,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text('Phone Number', style: AppTextStyle.labeltext),
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
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Password', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      obscureText: true,
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
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Confirm Password', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextField(
                      obscureText: true,
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
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'By continuing, you agree to the ',
                        style: AppTextStyle.loginsubhead),
                    TextSpan(
                      text: 'terms',
                      style: TextStyle(
                        color: Color(0xFF1E83FF),
                        fontSize: 12,
                        fontFamily: 'Mona Sans',
                        fontWeight: FontWeight.w500,
                        height: 1.33,
                        letterSpacing: 0.04,
                      ),
                    ),
                    TextSpan(text: ' and ', style: AppTextStyle.loginsubhead),
                    TextSpan(
                      text: 'privacy',
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
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(53),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {
                  log("Next button pressed");
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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        color: Color(0xFFFAFAFA),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 0),
              TextButton(
                onPressed: () {
                  log("sign in now pressed");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ));
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'Already have an account? ',
                          style: AppTextStyle.loginsubhead),
                      TextSpan(
                        text: 'Sign in',
                        style: TextStyle(
                          color: Color(0xFF1E83FF),
                          fontSize: 12,
                          fontFamily: 'Mona Sans',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
