import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_mini_project/constants/app_theme.dart';
import 'package:iot_mini_project/constants/strings.dart';
import 'package:iot_mini_project/screens/home-screen.dart';

 Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: AppThemeData.themeData(),
      home: const MyHomePage(),
    );
  }
}
