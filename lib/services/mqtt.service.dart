import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//load env file

class MqttService {
  //Readmore: https://pub.dev/packages/mqtt_client/example
  late MqttServerClient client;

  final List<String> pubTopics = [
    "hl01012002/feeds/iot-mini-project.air-conditioner",
    "hl01012002/feeds/iot-mini-project.fridge",
    "hl01012002/feeds/iot-mini-project.television",
    "hl01012002/feeds/iot-mini-project.washer",
  ];
  final List<String> subTopics = [
    "hl01012002/feeds/iot-mini-project.temp",
    "hl01012002/feeds/iot-mini-project.humid"
  ];

  final String clientId = 'RMX3357';
  final String username = 'hl01012002';
  final String password = dotenv.env['ADAFRUIT_IO_KEY']!;

  final String hostName = 'io.adafruit.com';

  //constructor
  MqttService(Function(String, String) onMessageReceived) {
    _loadEnv();
    client = MqttServerClient(hostName, clientId);
    client.logging(on: true);
    client.setProtocolV311();
    client.keepAlivePeriod = 20;
    client.connectTimeoutPeriod = 2000;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;
    client.onDisconnected = onDisconnected;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
            'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    connect();

    //callback when message received
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      onMessageReceived(c[0].topic, pt);
    });
  }

  //Connect to Adafruit
  Future<void> connect() async {
    try {
      await client.connect(username, password);
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      debugPrint('ERROR::client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      debugPrint('ERROR::socket exception - $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      debugPrint('DONE::Mosquitto client connected');
    } else {
      /// Use status here rather than state if you also want the broker return code.
      debugPrint(
          'ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    subscribe();
  }

  Future<void> _loadEnv() async {
    await dotenv.load();
  }

  //subscribe all subTopics
  void subscribe() {
    for (var topic in subTopics) {
      client.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  // callback when connected
  void onConnected() {
    debugPrint('DONE::Mosquitto client connected');
  }

  //callback when disconnected
  void onDisconnected() {
    print('END::Mosquitto client disconnected');
  }

  //callback when subscribed
  void onSubscribed(String topic) {
    print('DONE::: Sunscribe successfully $topic');
  }

  void publish(String pubTopic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }
}
