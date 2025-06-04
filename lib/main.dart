import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:workwista/view/Controllers/add_job_controller.dart';
import 'package:workwista/view/Controllers/apply_job_controller.dart';
import 'package:workwista/view/Controllers/complete_profile_controller.dart';
import 'package:workwista/view/Controllers/job_details_screen_controller.dart';
import 'package:workwista/view/Controllers/jobs_screen_controller.dart';
import 'package:workwista/view/Controllers/location_provider_controller.dart';
import 'package:workwista/view/Controllers/login_screen_controller.dart';
import 'package:workwista/view/Controllers/my_jobs_screen_controller.dart';
import 'package:workwista/view/Controllers/profile_screen_controller.dart';
import 'package:workwista/view/Controllers/register_screen_controller.dart';
import 'package:workwista/view/loginScreens/splash_screen.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
   setupFirebaseNotifications();
  runApp(const MyApp());
}



final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void setupFirebaseNotifications() {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
    }
  });
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
          create: (context) => LocationProvider(),
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
        ChangeNotifierProvider(
          create: (context) => CompleteProfileController(),
        ),
ChangeNotifierProvider(
          create: (context) => MyJobsScreenController(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: Size(393, 852),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0, // remove shadow
              scrolledUnderElevation: 0,
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'MonoSans',
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
