import 'package:flutter/material.dart';
import 'package:testintelij/src/screen/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFE50914), // Netflix Red
        hintColor: Colors.white,       // White accent for contrast
        backgroundColor: const Color(0xFF121212), // Dark background
        scaffoldBackgroundColor: const Color(0xFF121212),
        cardColor: const Color(0xFF1F1F1F), // Dark Gray for cards
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white70),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
