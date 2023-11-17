import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final IconData icon;
  final String hinttext;
  final bool showpassword;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.icon,
    required this.hinttext,
    required this.controller,
    required this.showpassword,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        right: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        bottom: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        left: BorderSide(color: Colors.white.withOpacity(0.5), width: 1, style: BorderStyle.solid, strokeAlign: 1),
        ),
      borderRadius: const BorderRadius.all(Radius.circular(36)),
      color: Colors.white.withOpacity(0.08)
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextField(
          obscureText: showpassword,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
          controller: controller,
          //eybdthcfkmyst rjvbgt
          decoration: InputDecoration.collapsed(
              hintText: hinttext,
              hintStyle: const TextStyle(color: Colors.white)
          ),),
          Container(
            alignment: Alignment.centerLeft,
            child: Container(
              alignment: Alignment.centerLeft,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white     
              ),
              child: Center(child: Icon(icon, size: 36, color: Colors.red))
              ),
            ),
          ),
          ]
      ));
  }
}