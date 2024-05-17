import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Notifications",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        backgroundColor: Colors.red,
          iconTheme: const IconThemeData(color: Colors.white)
      ),
      body: ListView(
        children: const [
          NotificationTile(
            name: "Lelah Barker",
            message: "@harlequin Could you schedule a coffee with...",
            time: "Today at 10:25",
            role: "Product Manager",
          ),
          NotificationTile(
            name: "Marius Friedman",
            message: "@team We’ve decided to invite Kelsie for a second interview 👍",
            time: "Yesterday",
            role: "Head of Growth",
          ),
          NotificationTile(
            name: "Ihsan Bows",
            message: "applied for Visual Designer",
            time: "2 days ago",
            role: "Visual Designer",
          ),
          NotificationTile(
            name: "Lelah Barker",
            message: "added you to the hiring team for Head of Growth",
            time: "2 days ago",
            role: "Head of Growth",
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String role;

  const NotificationTile({
    Key? key,
    required this.name,
    required this.message,
    required this.time,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showNotificationDialog(context, name, message, time, role),
      child: ListTile(
        title: Text(name,style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),),
        subtitle: Text("$message · $role"),
        trailing: Text(time),
      ),
    );
  }

  void _showNotificationDialog(BuildContext context, String name, String message, String time, String role) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Notification Details"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Name: $name"),
                Text("Role: $role"),
                Text("Message: $message"),
                Text("Time: $time"),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
