import 'package:diplom/Screens/Authorization_Sreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Diplom',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedLabelStyle: TextStyle(fontFamily: 'Comic Sans'),
          unselectedLabelStyle: TextStyle(fontFamily: 'Comic Sans'),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 52, 152, 219)),
        useMaterial3: true,
      ),
      home: const AuthrorizationScreen(),
    );
  }
}