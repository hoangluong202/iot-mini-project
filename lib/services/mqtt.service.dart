import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

//load env file

class MqttService {
  //Readmore: https://pub.dev/packages/mqtt_client/example
  static String hostName = 'io.adafruit.com';
  static String clientId = '12345678';
  final String username = 'hl01012002';
  final String password = dotenv.env['ADAFRUIT_IO_KEY']!;
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

  final MqttServerClient client = MqttServerClient(hostName, clientId);

  final Function(String, String) onMessage;

  //Connect to Adafruit
  Future<void> connect() async {
    try {
      await client.connect(username, password);
      subscribe();
    } catch (e) {
      debugPrint('EXAMPLE::client exception - $e');
      client.disconnect();
    }
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

  //
  void handleMessage() {
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      debugPrint(
          'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    });
  }

  // callback when connected
  void onConnected() {
    debugPrint('connected successfully');
  }

  //callback when disconnected
  void onDisconnected() {
    print('disconnected');
  }

  //callback when subscribed
  void onSubscribed(String topic) {
    print('subscribed on topic: $topic');
  }

  void publish(String pubTopic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload!);
  }

//GET LAST VALUE IN A TOPIC
  void getTheLastValue(String topic) {
   
    
  }

  //constructor
  MqttService(this.onMessage) {
    _loadEnv();
    connect();
    client.logging(on: true);
    client.setProtocolV311();
    client.keepAlivePeriod = 3600;
    //call back when connected
    client.onConnected = onConnected;
    //call back when subscribed
    client.onSubscribed = onSubscribed;
    //call back when disconnected
    client.onDisconnected = onDisconnected;
    //callback when message received
    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      debugPrint(
          'Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
      onMessage(c[0].topic, pt);
    });
  }
}
