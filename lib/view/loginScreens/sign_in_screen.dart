import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';
import 'package:workwista/view/loginScreens/forgot_password_screen.dart';
import 'package:workwista/view/loginScreens/signup_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset('assets/Workwista (1).png'),
            const Text('Welcome to Workwista 👋'),
            const Text(
                'Don\'t miss the opportunity to easily find jobs and hire workers.'),

            // Google Sign In Button
            ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/flat-color-icons_google.png'),
                  const Text('Sign up with Google'),
                ],
              ),
            ),

            const Text('or'),

            // Email/Phone Field
            TextField(
              controller: emailController,
              decoration:
                  const InputDecoration(labelText: 'Phone Number/Email'),
            ),

            // Password Field
            TextField(
              controller: passController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Forgotpassword()),
                );
              },
              child: const Text('Forgot Password?'),
            ),

            const Spacer(),

            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signupscreen()),
                );
              },
              child: const Text('Don\'t have an account? Sign up now'),
            ),

            // Login Button
         ElevatedButton(
  onPressed: () async {
    if (emailController.text.isNotEmpty && passController.text.isNotEmpty) {
      await context.read<LoginScreenController>().onLogin(
        email: emailController.text,
        password: passController.text,
        context: context, // Pass context to controller
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
    }
  },
  child: const Text('Login'),
),
          ],
        ),
      ),
    );
  }
}
