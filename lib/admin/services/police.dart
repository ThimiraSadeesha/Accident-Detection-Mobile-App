import 'package:flutter/material.dart';

class PoliceServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Police Services Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Add police service logic here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with actual police service count
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Police Station $index'),
            subtitle: Text('Contact: +1234567890\nLocation: ABC Area'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Edit police service logic
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete police service logic
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
