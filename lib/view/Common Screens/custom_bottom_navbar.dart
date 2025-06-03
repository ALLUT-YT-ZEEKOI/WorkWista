import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:workwista/Utils/app_utils.dart';
import 'package:workwista/view/loginScreens/homeScreens/add_job_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/dashboard_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/job_status_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/my_jobs_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/profile_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  final String? successMessage;
  const CustomBottomNavbar({this.successMessage, super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  @override
  void initState() {
    super.initState();
    if (widget.successMessage != null) {
      // Show SnackBar after widget builds
      WidgetsBinding.instance.addPostFrameCallback((_) {
        AppUtils.showSnackbar(
            context: context,
            message: widget.successMessage.toString(),
            bgcolor: Colors.green);
      });
    }
  }

  int _currentIndex = 0; // Track the currently selected tab

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    Dashboard(),
    JobStatusScreen(),
    AddJobScreen(),
    CategoriesScreen(),
    MyJobsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: Material(
        // color: Colors.white,
        // elevation: 0,
        child: BottomNavigationBar(
          selectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
          backgroundColor: Colors.white,
          // elevation: 0,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed, // For more than 3 items
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/home_nofill.png'),
              activeIcon: Image.asset('assets/home_fill.png'),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/job_status.png',
              ),
              activeIcon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFF48AAFF), // #48AAFF
                        Color(0xFF2B6699), // #2B6699
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.filter_tilt_shift)),
              label: 'Job Status',
            ),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Image.asset(
                    'assets/add_btn.png',
                    scale: 1.1,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 0.h),
                  child: Image.asset(
                    scale: 1.1,
                    'assets/add_btn.png',
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/categories_nofill.png',
              ),
              activeIcon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFF48AAFF), // #48AAFF
                        Color(0xFF2B6699), // #2B6699
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Icon(Icons.category)),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/briefcase.png',
              ),
              activeIcon: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [
                        Color(0xFF48AAFF), // #48AAFF
                        Color(0xFF2B6699), // #2B6699
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.srcIn,
                  child: Image.asset(
                    'assets/briefcase_fill.png',
                    color: Colors
                        .white, // Important: Set to white for gradient to show
                  )),
              label: 'My Jobs',
            ),
          ],
          selectedItemColor: Colors.blue, // Customize selected color
          unselectedItemColor: Colors.black, // Customize unselected color
        ),
      ),
    );
  }
}
