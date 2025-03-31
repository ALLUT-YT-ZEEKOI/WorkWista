import 'package:flutter/material.dart';
import 'package:workwista/view/loginScreens/homeScreens/categories_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/dashboard_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/my_jobs_screen.dart';
import 'package:workwista/view/loginScreens/homeScreens/profile_screen.dart';

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  State<CustomBottomNavbar> createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _currentIndex = 0; // Track the currently selected tab

  // List of screens to display based on the selected index
  final List<Widget> _screens = [
    Dashboard(),
    MyJobsScreen(),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue, // Customize selected color
        unselectedItemColor: Colors.grey, // Customize unselected color
      ),
    );
  }
}
