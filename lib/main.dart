import 'package:accident_detection_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final MqttService mqttService = MqttService();

  @override
  Widget build(BuildContext context) {
    mqttService.connect(); // Connect to the broker when the app starts
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen()
    );
  }
}

class MqttService {
  final String serverUri = '15.235.192.41';
  final int port = 1883;
  final String clientId = 'flutter_client';
  final String username = 'sadee';
  final String password = 'qwerty';

  MqttServerClient? client; // Nullable client

  MqttService() {
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
        .withWillTopic('willtopic') // Optional
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
          final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
          final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

          print('Received message: $pt from topic: ${c[0].topic}');

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
