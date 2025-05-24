import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';
import 'package:workwista/view/Controllers/register_screen_controller.dart';
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
  final _formKey = GlobalKey<FormState>();
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
          child: Form(
            key: _formKey,
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
                      _buildTextField(
                    controller: emailController,
                    label: 'Phone Number/Email',
                    fieldKey: 'email',
                    loginController: controller,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 20.h),
                  _buildTextField(
                    controller: passController,
                    label: 'Password',
                    fieldKey: 'password',
                    loginController: controller,
                    obscureText: true,
                    textInputAction: TextInputAction.done,
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
                    child: Text(
            'Forgot Password?',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
                    ),
                  ),
                    ],
                  ),
                ),
            // Display general error if exists
            if (controller.generalError != null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.w),
                    // ignore: deprecated_member_use
                    border: Border.all(color: Colors.red.withOpacity(0.3)),
                  ),
                  child: Text(
                    controller.generalError!,
                    style: TextStyle(
            color: Colors.red,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
                SizedBox(height: 40.h),
            
                // Sign up text
                GestureDetector(
                  onTap: () {
                  context.read<LoginScreenController>().clearErrors(); // Add this line
                context.read<RegisterScreenController>().clearErrors();
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
                                bool formvalid = _formKey.currentState!.validate();


                          if (formvalid) {
                            await context.read<LoginScreenController>().onLogin(
                                  email: emailController.text,
                                  password: passController.text,
                                  context: context,
                                );
                          } 
                          // else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     const SnackBar(
                          //         content:
                          //             Text("Please enter email and password")),
                          //   );
                          // }
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
      ),
    );
  }

  Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String fieldKey,
  required LoginScreenController loginController,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  TextInputAction textInputAction = TextInputAction.next,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      SizedBox(height: 5.h),
      SizedBox(
        height: 50.h,
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            // Disable default error text to prevent height change
            errorStyle: TextStyle(height: 0, fontSize: 0),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(33.w),
              borderSide: BorderSide(
                color: loginController.fieldErrors[fieldKey] != null 
                    ? Colors.red 
                    : Color(0xFFBDBDBD),
                width: loginController.fieldErrors[fieldKey] != null ? 2.w : 1.w,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(33.w),
              borderSide: BorderSide(
                color: loginController.fieldErrors[fieldKey] != null 
                    ? Colors.red 
                    : Color(0xFFBDBDBD),
                width: loginController.fieldErrors[fieldKey] != null ? 2.w : 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(33.w),
              borderSide: BorderSide(
                color: loginController.fieldErrors[fieldKey] != null 
                    ? Colors.red 
                    : Color(0xFF757575),
                width: 1.5.w,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(33.w),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(33.w),
              borderSide: BorderSide(color: Colors.red, width: 2.w),
            ),
          ),
        ),
      ),
      // Show error text below the field
      if (loginController.fieldErrors[fieldKey] != null)
        Padding(
          padding: EdgeInsets.only(top: 4.h, left: 12.w),
          child: Text(
            loginController.fieldErrors[fieldKey]!,
            style: TextStyle(color: Colors.red, fontSize: 12.sp),
          ),
        ),
    ],
  );
}

}
