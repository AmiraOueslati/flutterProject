import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/animal_history_screen.dart';
// Make sure to import this screen if needed
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SheepHistoryPage(sensorId: 1,), // Show the SplashScreen first
    );
  }
}
