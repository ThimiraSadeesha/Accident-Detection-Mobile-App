import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Alerts'),
      ),
      body: ListView.builder(
        itemCount: 3,  // Replace with real-time alert data
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Alert ID: $index'),
            subtitle: Text('Status: Active'),
            onTap: () {
              // View emergency details
            },
          );
        },
      ),
    );
  }
}
