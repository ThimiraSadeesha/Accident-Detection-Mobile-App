import 'package:flutter/material.dart';

class AccidentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accident Management'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual accident count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Accident ID: $index'),
            subtitle: Text('Location: XYZ\nStatus: Pending'),
            onTap: () {
              // View full incident details and assign services
            },
          );
        },
      ),
    );
  }
}
