// ignore_for_file: non_constant_identifier_names, file_names

import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';

class LessonCompleteTypeWidget extends StatelessWidget {
  final LessonStateTypes LessonTypes;

  const LessonCompleteTypeWidget({super.key, required this.LessonTypes});

  @override
  Widget build(BuildContext context) {
    if (LessonTypes == LessonStateTypes.Current) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Icon(
          Icons.arrow_right_rounded,
          color: Colors.blue,
          size: 40,
        ),
      );
    } else if (LessonTypes == LessonStateTypes.Completed) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.green,
          size: 40,
        ),
      );
    } else if (LessonTypes == LessonStateTypes.Blocked) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 2),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.lock_outline_rounded,
          color: Colors.black.withOpacity(0.3),
          size: 40,
        ),
      );
    }
    return Container();
  }
}
