import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workwista/Utils/color_constants.dart';
import 'package:workwista/view/Controllers/complete_profile_controller.dart';
import 'package:workwista/view/Wdigets/gradient_button.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _dobController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime latestAllowed =
        DateTime(today.year - 18, today.month, today.day); // Max date
    DateTime earliestAllowed = DateTime(1900); // Arbitrary earliest date
    DateTime defaultDate =
        DateTime(today.year - 25); // Default selected date (optional)
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: defaultDate,
      firstDate: earliestAllowed,
      lastDate: latestAllowed,
      builder: (context, child) {
        return Theme(
            data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                    primary: Colors.blue.shade900,
                    onPrimary: Colors.white,
                    onSurface: Colors.black),
                textButtonTheme: TextButtonThemeData(
                    style:
                        TextButton.styleFrom(foregroundColor: Colors.black))),
            child: child!);
      },
    );

    if (pickedDate != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(pickedDate); // format date
      setState(() {
        _dobController.text = formattedDate; // set to TextField
      });

      // Now you can use the formattedDate string wherever needed
      print("Selected date: $formattedDate");
    }
  }

  @override
  void dispose() {
    _dobController.dispose();
    _phoneNoController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final controller = Provider.of<CompleteProfileController>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Complete your proofile",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  textAlign: TextAlign.center,
                  "Complete your profile and continue to your account",
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.descText),
                ),
                SizedBox(
                  height: 80.h,
                ),
                Text(
                  "Full name",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.h,
                ),
                _textFields(context, double.infinity, "Enter your full name",
                    _nameController),
                SizedBox(
                  height: 5.h,
                ),
                // Show error text below the field
                if (controller.fieldErrors["name"] != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 20.w),
                    child: Text(
                      controller.fieldErrors["name"]!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                Text(
                  "Phone number",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.h,
                ),
                _textFields(context, double.infinity, "Enter your phone number",
                    _phoneNoController),
                SizedBox(
                  height: 5.h,
                ),
                // Show error text below the field
                if (controller.fieldErrors["phone_number"] != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 20.w),
                    child: Text(
                      controller.fieldErrors["phone_number"]!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),

                SizedBox(
                  height: 18.h,
                ),
                Text(
                  "Date of birth",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5.h,
                ),
                _textFields(context, double.infinity,
                    "Enter your date of birth", _dobController,
                    ontap: () => _selectDate(context)),
                if (controller.fieldErrors["DOB"] != null)
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, left: 12.w),
                    child: Text(
                      controller.fieldErrors["DOB"]!,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  ),
                SizedBox(
                  height: 50.h,
                ),
                GradientButton(
                    name: "Complete",
                    onPressed: () async {
                      bool formvalid = _formKey.currentState!.validate();
                      if (formvalid) {
                        final FirebaseMessaging _firebaseMessaging =
                            FirebaseMessaging.instance;
                        String? token = await _firebaseMessaging.getToken();
                        log(token.toString());
                        await context
                            .read<CompleteProfileController>()
                            .onUpdateProfile(
                                name: _nameController.text,
                                fcm_token: token ?? "empty",
                                phone_number: _phoneNoController.text,
                                DOB: _dobController.text,
                                context: context);
                      }
                    },
                    height: 50.h,
                    width: double.infinity.w),
                SizedBox(
                  height: 20.h,
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
