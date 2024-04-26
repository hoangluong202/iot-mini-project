import 'package:flutter/material.dart';

class AppHeading extends StatelessWidget {
  const AppHeading({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(title),
    );
  }
}
