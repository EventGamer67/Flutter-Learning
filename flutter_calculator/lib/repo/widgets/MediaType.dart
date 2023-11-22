import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/Feeling_model.dart';

class MediaType extends StatelessWidget {
  final Feeling feeling;
  const MediaType({super.key, required this.feeling });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Image(image: NetworkImage(feeling.image)),
          ),
          FittedBox(
            child: Text(
              feeling.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12
              ),
              ),
          )
        ]
        ),
    );
  }
}