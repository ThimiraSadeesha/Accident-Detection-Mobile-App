import 'dart:convert';

import 'package:accident_detection_app/screens/dashboard/home/notification-provider/notification-provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:accident_detection_app/screens/welcome/welcome.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    ChangeNotifierProvider(
      create: (_) => NotificationProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late MqttService mqttService;

  @override
  void initState() {
    super.initState();
    mqttService = MqttService(navigatorKey);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      mqttService.connect();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class MqttService {
  final String serverUri = '15.235.192.41';
  final int port = 1883;
  final String clientId = 'flutter_client';
  final String username = 'sadee';
  final String password = 'qwerty';
  final GlobalKey<NavigatorState> navigatorKey;
  List<String> notifications = [];


  // void _saveMessage(String message) {
  //   notifications.add(message);
  //   if (notifications.length > 100) {
  //     notifications.removeAt(0);
  //   }
  // }

  MqttServerClient? client;

  MqttService(this.navigatorKey) {
    client = MqttServerClient(serverUri, clientId);
    client?.port = port;
    client?.keepAlivePeriod = 20;
    client?.onDisconnected = onDisconnected;
    client?.onConnected = onConnected;
    client?.logging(on: true);

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .authenticateAs(username, password)
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client?.connectionMessage = connMessage;
  }

  Future<void> connect() async {
    try {
      await client?.connect(username, password);
      if (client?.connectionStatus?.state == MqttConnectionState.connected) {
        print('MQTT client connected');
        client?.subscribe('esp/1/mpu6050', MqttQos.atMostOnce);
        client?.subscribe('esp/1/adxl345', MqttQos.atMostOnce);
        client?.subscribe('esp/1/accident', MqttQos.atMostOnce);

        client?.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final String topic = c[0].topic;
          if (topic == 'esp/1/accident') {
            final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
            final String payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
            final Map<String, dynamic> message = jsonDecode(payload);
            final String messageContent = message['message'];
            _showAccidentDialog(messageContent);
            _saveMessage(messageContent);
          }
        });
      } else {
        print('ERROR: MQTT client connection failed - '
            'status is ${client?.connectionStatus}');
        client?.disconnect();
      }
    } catch (e) {
      print('Exception: $e');
      client?.disconnect();
    }
  }

  Future<void> _saveMessagesToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('notifications', notifications);
  }
  void _saveMessage(String message) {
    // Add the message to the global provider
    navigatorKey.currentContext!.read<NotificationProvider>().addNotification(message);
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    notifications = prefs.getStringList('notifications') ?? [];
  }



  void _showAccidentDialog(String message) {
    Navigator.of(navigatorKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) {
          return AlertDialog(
            title: const Text('Accident Detected'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning, color: Colors.red, size: 40),
                const SizedBox(height: 20),
                Text('Message: $message'),
                const SizedBox(height: 20),
                const Text(
                  'Are you okay?',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
              ),
            ],
          );
        },
      ),
    );
  }



  void onConnected() {
    print('Connected to the broker');
  }

  void onDisconnected() {
    print('Disconnected from the broker');
  }

  void disconnect() {
    client?.disconnect();
  }
}
