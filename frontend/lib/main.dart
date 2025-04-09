import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page_content.dart';
import 'package:frontend/pages/navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromARGB(255, 68, 212, 152), 
        useMaterial3: true,
        //brightness: Brightness.dark,
        
      ),
      title: 'Home Page',
      home: NavigationBarApp(),
    );
  }
}