import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page_content.dart';
import 'package:frontend/pages/planning.dart';
import 'package:frontend/pages/recipe.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({super.key});

  @override
  State<NavigationBarApp> createState() => _NavBarState();
}

class _NavBarState extends State<NavigationBarApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(), // Your main home page
    WeeklyPlannerScreen(), // Replace with actual widget
  ];

  void _onNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label:"Home"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label:"Weekly Planner")
        ] ),
    );
  }
}
