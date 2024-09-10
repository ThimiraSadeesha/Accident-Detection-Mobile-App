import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String serverUri = '15.235.192.41';
  final int port = 1883;
  final String clientId = 'flutter_client';
  final String username = 'sadee';
  final String password = 'qwerty';

  MqttServerClient? client; // Nullable client
  final VoidCallback onConnectedCallback;

  MqttService({required this.onConnectedCallback}) {
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
        onConnectedCallback();
        client?.subscribe('esp/1/mpu6050', MqttQos.atMostOnce);
        client?.subscribe('esp/1/adxl345', MqttQos.atMostOnce);
        client?.subscribe('esp/1/accident', MqttQos.atMostOnce);

        client?.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
          final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          // print('Received message: $pt from topic: ${c[0].topic}');

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
    onConnectedCallback();
  }

  void onDisconnected() {
    print('Disconnected from the broker');
  }

  void disconnect() {
    client?.disconnect();
  }

  void _showMessageDialog(BuildContext context, String payload, String topic) {
    Map<String, dynamic> messageData = jsonDecode(payload);
    String deviceId = messageData['id'] ?? 'Unknown Device';
    String message = messageData['message'] ?? 'No message';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert from $deviceId',
            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 50.0,
              ),
              const SizedBox(height: 16),
              Text(message), // Display the extracted message
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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
