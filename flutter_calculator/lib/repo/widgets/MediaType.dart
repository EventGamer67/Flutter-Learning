import 'package:flutter/material.dart';
import 'package:flutter_calculator/models/Feeling_model.dart';

class MediaType extends StatelessWidget {
  final Feeling feeling;
  const MediaType({super.key, required this.feeling });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 65,
            height: 66,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Image(image: NetworkImage(feeling.image)),
          ),
          Text(
            feeling.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12
            ),
            )
        ]
        ),
    );
  }
}