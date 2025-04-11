import 'package:flutter/material.dart';
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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            // Logo and welcome text
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  'assets/Workwista (1).png',
                  width: screenWidth * 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Welcome to Workwista 👋',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Don\'t miss the opportunity to easily find jobs and hire workers.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              
              // Google sign-in button
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: const Color(0xFFBDBDBD), width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/flat-color-icons_google.png',
                      width: screenWidth * 0.07
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Sign up with Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // OR Divider
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(color: Color(0xFFCED7DE), thickness: 1)
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      'or',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      )
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Color(0xFFCED7DE), thickness: 1)
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Login Fields
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Phone Number/Email',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
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
                    const SizedBox(height: 20),
                    const Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: passController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
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
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Forgotpassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        )
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              
              // Sign up text
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Signupscreen()
                    ),
                  );
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign up now',
                        style: TextStyle(
                          color: Color(0xFF1E83FF),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              
              // Login button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(53),
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
                        content: Text("Please enter email and password")),
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
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
