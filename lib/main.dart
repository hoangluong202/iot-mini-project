import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iot_mini_project/constants/app_theme.dart';
import 'package:iot_mini_project/screens/home-screen.dart';

 Future main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //const constructor
  const MyApp({super.key});

  //use method build from StatelessWidget
  //BuildContext is a handle to the location of a widget in the widget tree
  //build method returns a widget such as render a button, a form, a dialog, etc.
  //build method is called when the parent widget is rendered
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home',
      theme: AppThemeData.themeData(),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
