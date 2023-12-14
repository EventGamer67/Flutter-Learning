import 'package:diplom/Screens/Authorization_Sreen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

Future<void> main() async {

  await Supabase.initialize(
    url: 'https://gaxlrywbsvtamlbizmjt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdheGxyeXdic3Z0YW1sYml6bWp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDIyNzU4NTYsImV4cCI6MjAxNzg1MTg1Nn0.7bVx2U7_9xGbHTQQFfMEfv3OjsE00zfj4k9zSdvepoY',
  );
  final sup = Supabase.instance;
  GetIt.I.registerSingleton<Supabase>(sup);

  final dat = Data();
  GetIt.I.registerSingleton<Data>(dat);

  final talker = Talker();
  GetIt.I.registerSingleton<Talker>(talker);

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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 52, 152, 219)),
        useMaterial3: true,
      ),
      home: const AuthrorizationScreen(),
    );
  }
}