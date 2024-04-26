import 'package:flutter/material.dart';
import 'package:iot_mini_project/ui/home/home-screen.dart';

class Routes {
  Routes._();

  static const String home = '/post';

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) =>
        MyHomePage()
  };
}
