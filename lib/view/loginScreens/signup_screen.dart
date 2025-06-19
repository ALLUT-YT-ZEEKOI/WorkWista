import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _CPasswordController = TextEditingController();

  // Date selection variables
  DateTime currentDate = DateTime.now();
  late List<int> days;
  late List<int> months;
  late List<int> years;
  bool _dateError = false;
  
  int? selectedDay;
  int? selectedMonth;
  int? selectedYear;

  @override
  void initState() {
    super.initState();
    _initializeDateLists();
  }

  void _initializeDateLists() {
    currentDate = DateTime.now();
    
    // Generate years from 1970 to current year
    years = List.generate(
      currentDate.year - 1970 + 1, 
      (index) => 1970 + index
    ).reversed.toList(); // Reverse to show current year first
    
    // Initialize with all months and days
    months = List.generate(12, (index) => index + 1);
    days = List.generate(31, (index) => index + 1);
  }

  void _updateDaysForSelectedMonth() {
    if (selectedYear == null || selectedMonth == null) {
      days = List.generate(31, (index) => index + 1);
      return;
    }

    // Get the number of days in the selected month
    int daysInMonth = DateTime(selectedYear!, selectedMonth! + 1, 0).day;
    days = List.generate(daysInMonth, (index) => index + 1);
    
    // Reset day if current selection is invalid for the new month
    if (selectedDay != null && selectedDay! > daysInMonth) {
      selectedDay = null;
    }
  }

  Widget _dateDropdown({
    required String hint,
    required int? value,
    required List<int> items,
    required void Function(int?) onChanged,
    required String type,
  }) {
    return DropdownButtonFormField2<int>(
      value: value,
      items: items.map((int item) {
        return DropdownMenuItem<int>(
          value: item,
          child: Text(
            type == 'month'
                ? _getMonthName(item)
                : item.toString().padLeft(type == 'day' ? 2 : 4, '0'),
            style: TextStyle(fontSize: 14.sp),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        onChanged(newValue);

        // Handle cascading updates
        if (type == 'year') {
          setState(() {
            selectedMonth = null;
            selectedDay = null;
          });
        } else if (type == 'month') {
          setState(() {
            selectedDay = null;
            _updateDaysForSelectedMonth();
          });
        }

        // Clear date error when user selects a value
        if (_dateError) {
          setState(() {
            _dateError = false;
          });
        }
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53.r),
          borderSide: BorderSide(
            color: _dateError ? Colors.red : ColorConstants.containerBorder,
            width: _dateError ? 2.w : 1.w,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53.r),
          borderSide: BorderSide(
            color: _dateError ? Colors.red : ColorConstants.containerBorder,
            width: _dateError ? 2.w : 1.w,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53.r),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.w,
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(53.r),
          borderSide: BorderSide(color: ColorConstants.containerBorder),
        ),
      ),
      buttonStyleData: ButtonStyleData(
        height: 50.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 200.h,
        width: null,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        offset: const Offset(0, -4),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: _dateError ? Colors.red : ColorConstants.descText,
        ),
        iconSize: 24.w,
      ),
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: 14.sp,
          color: _dateError ? Colors.red : ColorConstants.descText,
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Date of Birth', style: AppTextStyle.labeltext),
        SizedBox(height: 5.h),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: _dateDropdown(
                hint: 'Year',
                value: selectedYear,
                items: years,
                type: 'year',
                onChanged: (value) => setState(() => selectedYear = value),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 3,
              child: _dateDropdown(
                hint: 'Month',
                value: selectedMonth,
                items: months,
                type: 'month',
                onChanged: (value) => setState(() => selectedMonth = value),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              flex: 2,
              child: _dateDropdown(
                hint: 'Day',
                value: selectedDay,
                items: days,
                type: 'day',
                onChanged: (value) => setState(() => selectedDay = value),
              ),
            ),
          ],
        ),
        // Error text for date selection
        if (_dateError)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 12.w),
            child: Text(
              'Please select complete date (day, month, year)',
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
              ),
            ),
          ),
        // Show additional validation error from controller
        if (context.watch<RegisterScreenController>().fieldErrors["DOB"] != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 12.w),
            child: Text(
              context.read<RegisterScreenController>().fieldErrors["DOB"]!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }

  String? _getFormattedDate() {
    if (selectedDay != null && selectedMonth != null && selectedYear != null) {
      return '${selectedYear!}-${selectedMonth!.toString().padLeft(2, '0')}-${selectedDay!.toString().padLeft(2, '0')}';
    }
    return null;
  }

  bool _validateDateSelection() {
    if (selectedDay == null || selectedMonth == null || selectedYear == null) {
      setState(() => _dateError = true);
      return false;
    } else {
      setState(() => _dateError = false);
      return true;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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
      ),
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
                    if (controller.fieldErrors["email"] != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h, left: 12.w),
                        child: Text(
                          controller.fieldErrors["email"]!,
                          style: TextStyle(color: Colors.red, fontSize: 12.sp),
                        ),
                      ),
                    SizedBox(height: 20.h),

                    // Date of Birth Field - REPLACED WITH DROPDOWN STYLE
                    _buildDateSection(),
                    SizedBox(height: 20.h),

                    // Phone Number Field
                    Text('Phone Number', style: AppTextStyle.labeltext),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        // Country code container
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorConstants.containerBorder),
                            borderRadius: BorderRadius.circular(53.r),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 20.w,
                                height: 14.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFF9933),
                                      Color(0xFFFF9933),
                                      Colors.white,
                                      Colors.white,
                                      Color(0xFF138808),
                                      Color(0xFF138808),
                                    ],
                                    stops: [0, 0.33, 0.33, 0.66, 0.66, 1],
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text('+91',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // Phone number input field
                        Expanded(
                          child: _textFields(
                            context,
                            double.infinity,
                            'Enter phone number',
                            _phoneNumberController,
                            KeyBoardType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
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
                    bool dateValid = _validateDateSelection();

                    if (formvalid && dateValid) {
                      final FirebaseMessaging _firebaseMessaging =
                          FirebaseMessaging.instance;
                      String? token = await _firebaseMessaging.getToken();
                      log("FCM token passed : $token");
                      
                      String? formattedDate = _getFormattedDate();
                      
                      await context.read<RegisterScreenController>().onRegister(
                          fcm_token: token,
                          name: _nameController.text,
                          context: context,
                          email: _emailController.text,
                          phone_number: "+91${_phoneNumberController.text}",
                          DOB: formattedDate!,
                          password: _passwordController.text,
                          confirm_pass: _CPasswordController.text);
                    }
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

  SizedBox _textFields(BuildContext context, double width, String hint,
      TextEditingController controller,
      {VoidCallback? ontap,
      String? Function(String?)? validator,
      TextInputType? KeyBoardType,
      List<TextInputFormatter>? inputFormatter}) {
    return SizedBox(
      width: width.w,
      height: 50.h,
      child: TextFormField(
        inputFormatters: inputFormatter,
        keyboardType: KeyBoardType,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          errorStyle: TextStyle(height: 0, fontSize: 0),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
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