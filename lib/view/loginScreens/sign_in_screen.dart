import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';
import 'package:workwista/view/loginScreens/forgot_password_screen.dart';

import 'package:workwista/view/loginScreens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final controller = Provider.of<LoginScreenController>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 33.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo and welcome text
              SizedBox(height: 22.h),
              Center(
                child: Image.asset(
                  'assets/Workwista (1).png',
                  width: screenWidth * 0.4.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Welcome to Workwista 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Don\'t miss the opportunity to easily find jobs and hire workers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 72.h),

              // Google sign-in button
              InkWell(
                onTap: () {
                  controller.handleGoogleSignIn(context: context);
                },
                child: controller.isloadingG
                    ? CircularProgressIndicator()
                    : Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35.w),
                          border:
                              Border.all(color: Color(0xFFBDBDBD), width: 1.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/flat-color-icons_google.png',
                                width: screenWidth * 0.07.w),
                            SizedBox(width: 10.w),
                            Text('Sign up with Google',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ),
              ),
              SizedBox(height: 20.h),

              // OR Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Divider(color: Color(0xFFCED7DE), thickness: 1.h)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text('or',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Expanded(
                      child: Divider(color: Color(0xFFCED7DE), thickness: 1.h)),
                ],
              ),
              SizedBox(height: 20.h),

              // Login Fields
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone Number/Email',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFFBDBDBD),
                              width: 1.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFFBDBDBD),
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFF757575),
                              width: 1.5.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text('Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 5.h),
                    SizedBox(
                      height: 50.h,
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFFBDBDBD),
                              width: 1.w,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFFBDBDBD),
                              width: 1.w,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(33.w),
                            borderSide: BorderSide(
                              color: Color(0xFF757575),
                              width: 1.5.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Forgotpassword(),
                          ),
                        );
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          )),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Sign up text
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Signupscreen()),
                  );
                },
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up now',
                        style: TextStyle(
                          color: Color(0xFF1E83FF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Login button
              controller.isloading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(53.w),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () async {
                        if (emailController.text.isNotEmpty &&
                            passController.text.isNotEmpty) {
                          await context.read<LoginScreenController>().onLogin(
                                email: emailController.text,
                                password: passController.text,
                                context: context,
                              );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Please enter email and password")),
                          );
                        }
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment(0.00, 0.50),
                            end: Alignment(1.00, 0.50),
                            colors: [Color(0xFF56A2FF), Color(0xFF00316D)],
                          ),
                          borderRadius: BorderRadius.circular(53.w),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFFAFAFA),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
