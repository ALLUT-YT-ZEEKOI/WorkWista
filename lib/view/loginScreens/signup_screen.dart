import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:workwista/AppTextStyle/app_text_style.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 45),
               Text(
                'Sign up for an account now!',
                textAlign: TextAlign.center,
                style: AppTextStyle.heading,
              ),
              const SizedBox(height: 10),
               Text(
                'Join us for job opportunities!',
                textAlign: TextAlign.center,
                style: AppTextStyle.loginsubhead,
              ),
              const SizedBox(height: 40),

              // Form Fields
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text('Your name', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _nameController,
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
                   Text('Email', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _emailController,
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
                   Text('Date of Birth', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(33),
                        borderSide: const BorderSide(
                          color: Color(0xFFBDBDBD),
                          width: 1,
                        ),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  const SizedBox(height: 20),
                   Text('Phone Number', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _phoneNumberController,
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
                   Text('Password', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _passwordController,
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
                   Text('Confirm Password', style: AppTextStyle.labeltext),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: _CPasswordController,
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
                onPressed: () async {
                  if (_nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _dateController.text.isNotEmpty &&
                      _phoneNumberController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _CPasswordController.text.isNotEmpty) {
                    await context.read<RegisterScreenController>().onRegister(
                        name: _nameController.text,
                        context: context,
                        email: _emailController.text,
                        phone_number: _phoneNumberController.text,
                        DOB: _dateController.text,
                        password: _passwordController.text,
                        confirm_pass: _CPasswordController.text);
                  }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter all details")),
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
                child:  Text.rich(
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
