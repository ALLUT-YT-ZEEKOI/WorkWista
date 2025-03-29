import 'package:flutter/material.dart';
import 'package:workwista/AppTextStyle/appTextStyle.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
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

            // OR Divider

            // Login Fields
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('your name', style: AppTextStyle.labeltext),
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
                const Text('Password', style: AppTextStyle.labeltext),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Day",
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
                    const SizedBox(width: 10), // Spacing between fields
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Month",
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
                    const SizedBox(width: 10), // Spacing between fields
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Year",
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

            // Pushes login button to the bottom
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: const SizedBox(
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
                            TextSpan(text: 'By continuing, you agree to the ', style: AppTextStyle.loginsubhead),
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
                    ),
                  ],
                ),
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
          ],
        ),
      ),
    );
  }
}
