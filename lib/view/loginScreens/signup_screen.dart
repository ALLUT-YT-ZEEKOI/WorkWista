import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workwista/AppTextStyle/app_text_style.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/register_screen_controller.dart';
import 'package:workwista/view/loginScreens/sign_in_screen.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _CPasswordController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // current date
      firstDate: DateTime(2000), // earliest date
      lastDate: DateTime(2100), // latest date
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate); // format date
      setState(() {
        _dateController.text = formattedDate; // set to TextField
      });

      // Now you can use the formattedDate string wherever needed
      print("Selected date: $formattedDate");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _CPasswordController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Provider.of<RegisterScreenController>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.read<RegisterScreenController>().clearErrors();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        elevation: 0, // remove shadow
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Text(
                  'Sign up for an account now!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.heading,
                ),
                SizedBox(height: 10.h),
                Text(
                  'Join us for job opportunities!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.loginsubhead,
                ),
                SizedBox(height: 40.h),

                // Form Fields
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name Field
                    Text('Your name', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(context, double.infinity, '', _nameController),
                    // Show error text below the field
                    if (controller.fieldErrors["name"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["name"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Email Field
                    Text('Email', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(context, double.infinity, '', _emailController),
                    // Show error text below the field
                    if (controller.fieldErrors["email"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["email"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Date of Birth Field
                    Text('Date of Birth', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(
                      context,
                      double.infinity,
                      '',
                      _dateController,
                      ontap: () => _selectDate(context),
                    ),

                    // Show error text below the field
                    if (controller.fieldErrors["DOB"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["DOB"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Phone Number Field
                    Text('Phone Number', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(
                        context, double.infinity, '', _phoneNumberController),
                    // Show error text below the field
                    if (controller.fieldErrors["phone_number"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["phone_number"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Password Field
                    Text('Password', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(
                        context, double.infinity, '', _passwordController),
                    // Show error text below the field
                    if (controller.fieldErrors["password"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["password"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Confirm Password Field
                    Text('Confirm Password', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    _textFields(
                        context, double.infinity, '', _CPasswordController),
                    // Show error text below the field
                    if (controller.fieldErrors["confirm_pass"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["confirm_pass"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 30.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'By continuing, you agree to the ',
                          style: AppTextStyle.loginsubhead),
                      TextSpan(
                        text: 'terms',
                        style: TextStyle(
                          color: Color(0xFF1E83FF),
                          fontSize: 12.sp,
                          fontFamily: 'Mona Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.33.h,
                          letterSpacing: 0.04.w,
                        ),
                      ),
                      TextSpan(text: ' and ', style: AppTextStyle.loginsubhead),
                      TextSpan(
                        text: 'privacy',
                        style: TextStyle(
                          color: Color(0xFF1E83FF),
                          fontSize: 12.sp,
                          fontFamily: 'Mona Sans',
                          fontWeight: FontWeight.w500,
                          height: 1.33.h,
                          letterSpacing: 0.04.w,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity.w, 50.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(53.w),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed: () async {
                    bool formvalid = _formKey.currentState!.validate();

                    if (formvalid) {
                      await context.read<RegisterScreenController>().onRegister(
                          name: _nameController.text,
                          context: context,
                          email: _emailController.text,
                          phone_number: _phoneNumberController.text,
                          DOB: _dateController.text,
                          password: _passwordController.text,
                          confirm_pass: _CPasswordController.text);
                    }
                    // else {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(content: Text("Please enter all details")),
                    //   );
                    // }
                  },
                  child: controller.isloading
                      ? CircularProgressIndicator()
                      : Ink(
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
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: Color(0xFFFAFAFA),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                ),
                SizedBox(height: 0.h),
                TextButton(
                  onPressed: () {
                    log("sign in now pressed");
                    context.read<RegisterScreenController>().clearErrors();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ));
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Already have an account? ',
                            style: AppTextStyle.loginsubhead),
                        TextSpan(
                          text: 'Sign in',
                          style: TextStyle(
                            color: Color(0xFF1E83FF),
                            fontSize: 12.sp,
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
      ),
    );
  }

  SizedBox _textFields(
    BuildContext context,
    double width,
    String hint,
    TextEditingController controller, {
    VoidCallback? ontap,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      width: width.w,
      height: 50.h,
      child: TextFormField(
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          // Disable error text to prevent height change
          errorStyle: TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.red, width: 2), // Make error more visible
              borderRadius: BorderRadius.circular(53.r)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.containerBorder),
              borderRadius: BorderRadius.circular(53.r)),
          hintText: hint,
          hintStyle: TextStyle(color: ColorConstants.descText),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorConstants.containerBorder),
              borderRadius: BorderRadius.circular(53.r)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(53.r),
            borderSide: BorderSide(color: ColorConstants.containerBorder),
          ),
        ),
        onTap: ontap,
      ),
    );
  }
}
