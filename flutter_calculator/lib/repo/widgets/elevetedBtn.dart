import 'package:flutter/material.dart';

class elevatedBtn extends StatelessWidget {

  final Function()? onTap;
  final String tittle;

  const elevatedBtn({super.key, required this.tittle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 124, 154, 146),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(
                color: Colors.white,
                //fontWeight: FontWeight.bold,
                fontWeight: FontWeight.w500,
                fontFamily: 'AlegreyaSans',
                fontSize: 25
              ),
            ),
          )
          ),
        ),
      ),
    );
  }
}