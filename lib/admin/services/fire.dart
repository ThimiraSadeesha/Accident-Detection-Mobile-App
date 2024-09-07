import 'package:flutter/material.dart';

class FireServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospital Services Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add hospital service logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual hospital service count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Hospital $index'),
            subtitle: Text('Contact: +1234567890\nLocation: XYZ Area'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Edit hospital service logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete hospital service logic
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
