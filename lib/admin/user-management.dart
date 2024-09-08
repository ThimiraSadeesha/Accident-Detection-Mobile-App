import 'package:flutter/material.dart';

class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Users'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('User Name $index'),
            subtitle: Text('Contact Info\nVehicle Info'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {

            },
          );
        },
      ),
    );
  }
}
