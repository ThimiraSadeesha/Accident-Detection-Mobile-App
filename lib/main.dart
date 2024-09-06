import 'package:accident_detection_app/screens/dashboard/home/map_screen.dart';
import 'package:accident_detection_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const Runner());
}

class Runner extends StatelessWidget {
  const Runner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
      // home: const MyHomePage(),
    );
  }
}
