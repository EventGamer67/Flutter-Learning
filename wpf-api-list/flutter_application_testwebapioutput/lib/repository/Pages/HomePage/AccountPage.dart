import 'package:flutter/material.dart';

class HomePageAccoundPage extends StatefulWidget {
  const HomePageAccoundPage({super.key});

  @override
  State<HomePageAccoundPage> createState() => _HomePageAccoundPageState();
}

class _HomePageAccoundPageState extends State<HomePageAccoundPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: Text("Account Page")));
  }
}