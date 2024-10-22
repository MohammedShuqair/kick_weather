import 'package:flutter/material.dart';
import 'package:kick_gaza_s7/screens/location_weather.dart';
import 'package:kick_gaza_s7/screens/loading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingScreen(),
    );
  }
}
