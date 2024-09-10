import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:accident_detection_app/screens/welcome/welcome.dart';

void main() {
  runApp(MyApp());
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

            print('Received message from accident topic: $payload');
            _showAccidentDialog(messageContent);
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

  void _showAccidentDialog(String message) {
    navigatorKey.currentState?.push(
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
                const Text('Are you okay?'),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
              ),
              TextButton(
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
