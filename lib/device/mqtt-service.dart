import 'dart:ui';

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
        onConnectedCallback(); // Call the callback on successful connection

        // Subscribe to your topics
        client?.subscribe('esp/1/mpu6050', MqttQos.atMostOnce);
        client?.subscribe('esp/1/adxl345', MqttQos.atMostOnce);
        client?.subscribe('esp/1/accident', MqttQos.atMostOnce);

        client?.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage recMess = c[0].payload as MqttPublishMessage;
          final String pt = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          print('Received message: $pt from topic: ${c[0].topic}');
          // Process the message here
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
}
