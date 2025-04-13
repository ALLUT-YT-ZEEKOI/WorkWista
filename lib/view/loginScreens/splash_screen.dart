import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:workwista/view/Common%20Screens/custom_bottom_navbar.dart';
import 'package:workwista/view/loginScreens/sign_in_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String access_token = prefs.getString("access") ?? "";
        String refresh_token = prefs.getString("refresh") ?? "";

        if (access_token.isNotEmpty && refresh_token.isNotEmpty) {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CustomBottomNavbar()));
        }else{
Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInScreen()));
        }
        
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Keeps content centered in the middle
          children: [
            const Image(
              image: AssetImage('assets/Frame 26080486.png'),
              width: 100,
            ),
            const SizedBox(height: 20), // Adds spacing
            Image.asset(
              'assets/Workwista (1).png',
              width: screenWidth * 0.4,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20), // Adds spacing
            const SizedBox(
              width: 300,
              child: Text(
                'Find your next gig close by and connect with cool talent online!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Mona Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
