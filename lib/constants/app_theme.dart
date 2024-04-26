import 'package:flutter/material.dart';

class AppThemeData {
  AppThemeData._();

  static ThemeData themeData(){
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    );
  }
}
