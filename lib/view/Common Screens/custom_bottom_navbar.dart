import 'package:flutter/material.dart';
import 'package:workwista/view/loginScreens/homeScreens/add_job_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/dashboard_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/my_jobs_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/profile_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  final String? successMessage;
  const CustomBottomNavbar({this.successMessage,super.key});

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.successMessage!)),
        );
      });
    }
  }


  int _currentIndex = 0; // Track the currently selected tab

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    Dashboard(),
    MyJobsScreen(),
    AddJobScreen(),
    CategoriesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
              ),
            ),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
              icon: Image.asset('assets/add.png'),
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
                  'assets/add.png',
                  color: Colors
                      .white, // Important: Set to white for gradient to show
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
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
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
                child: Icon(
                  Icons.person,
                )),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Customize selected color
        unselectedItemColor: Colors.black, // Customize unselected color
      ),
    );
  }
}
