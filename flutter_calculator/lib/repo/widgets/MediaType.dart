import 'package:flutter/material.dart';

class MediaType extends StatelessWidget {
  const MediaType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Image(image: AssetImage("assets/img/Logo.png")),
          FittedBox(
            child:Container(
              width: 60,
              height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: const Icon(Icons.access_alarm_sharp),
          ),
          ),
          const FittedBox(
            child: Text(
              "Спокойным",
              style: TextStyle(
                color: Colors.white
              ),
              ),
          )
        ]
        ),
    );
  }
}