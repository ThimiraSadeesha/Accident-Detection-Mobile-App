import 'package:flutter/material.dart';
import 'package:accident_detection_app/screens/welcome/welcome.dart';

import 'admin/dashboard-admin.dart';

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
      home:  DashboardPage(),
    );
  }
}

void backgroundTaskCallback() {
  // This function will be called by the foreground service
  print('Background service running...');
}
