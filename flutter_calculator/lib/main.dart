
import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/mainWindow.dart';
import 'package:flutter_calculator/Screens/onboard.dart';
import 'package:flutter_calculator/Screens/registration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const OnBoardWindow(),
      home: const MainWindow(),
      //home: const RegistrationWindow(),
    );
  }
}