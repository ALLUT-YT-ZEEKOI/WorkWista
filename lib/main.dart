import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/add_job_controller.dart';
import 'package:workwista/view/Controllers/apply_job_controller.dart';
import 'package:workwista/view/Controllers/job_details_screen_controller.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';
import 'package:workwista/view/Controllers/profile_screen_controller.dart';
import 'package:workwista/view/Controllers/register_screen_controller.dart';
import 'package:workwista/view/loginScreens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AddJobController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ApplyJobController(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobsScreenController(),
        ),
       
        ChangeNotifierProvider(
          create: (context) => LoginScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => JobDetailsScreenController(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileScreenController(),
        ),
      ],
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'MonoSans',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
