// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:zameny_flutter/Services/Data.dart';
import 'package:zameny_flutter/Sreens/Schedule_Screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ojbsikxdqcbuvamygezd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9qYnNpa3hkcWNidXZhbXlnZXpkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDE4MDY4OTgsImV4cCI6MjAxNzM4Mjg5OH0.jV7YiBEePGjybsL8qqXWeQ9PX8_3yctpq14Gfwh39JM',
  );

  SupabaseClient client = Supabase.instance.client;
  GetIt.I.registerSingleton<SupabaseClient>(client);

  Data data = Data();
  GetIt.I.registerSingleton<Data>(data);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainScreen extends StatefulWidget {
  MainScreen({super.key, required this.title});

  final String title;
  final List<Widget> pages = [ScheduleScreen(), Placeholder(), Placeholder()];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        widget.pages[selectedPageIndex],
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  border: Border(
                      top: BorderSide(
                          color: const Color.fromARGB(255, 30, 118, 233),
                          width: 1))),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      bottomNavigationItem(
                          icon: Icons.school_rounded,
                          text: "Schedule",
                          selected: false),
                      bottomNavigationItem(
                          icon: Icons.code_rounded,
                          text: "Exams",
                          selected: false),
                      bottomNavigationItem(
                          icon: Icons.settings,
                          text: "Settings",
                          selected: false),
                    ],
                  ),
                ),
              ),
            )),
      ]),
    );
  }

  Padding bottomNavigationItem(
      {required IconData icon, required String text, required bool selected}) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
          height: 50,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 30, 118, 233),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 28, 95, 182),
                  blurStyle: BlurStyle.outer,
                  blurRadius: 6,
                )
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white),
              )
            ]),
          )),
    );
  }
}
