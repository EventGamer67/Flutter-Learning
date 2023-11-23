import 'package:flutter/material.dart';

class PlaceHolderPage extends StatelessWidget {
  final String placeholderText;

  const PlaceHolderPage({super.key, required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(37, 51, 52, 1),
      body: Center(
        child: Text(
          placeholderText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: 'Alegreya',
            fontWeight: FontWeight.w500,
            height: 0,
          ),
        ),
      ),
    );
  }
}
