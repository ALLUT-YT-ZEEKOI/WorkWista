import 'package:flutter/material.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Keeps content centered in the middle
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
