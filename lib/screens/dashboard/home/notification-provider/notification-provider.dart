import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  List<String> _notifications = [];

  List<String> get notifications => _notifications;

  void addNotification(String message) {
    _notifications.add(message);
    notifyListeners(); // Notify UI to update
  }
}
