// ignore_for_file: file_names

import 'package:diplom/Screens/LessonScreens/LectureScreen.dart';
import 'package:diplom/Screens/LessonScreens/practiceScreen.dart';
import 'package:diplom/Screens/LessonScreens/testLessonScreen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

Widget defineLessonPage(
    {required Lesson lesson, required bool alreadyCompleted}) {
  GetIt.I<Talker>().good(lesson.type);
  switch (lesson.type) {
    //lection
    case 1:
      return LessonScreen(
        lesson: lesson,
        alreadyCompleted: alreadyCompleted,
      );
    //test
    case 2:
      return TestLessonScreen(
        lesson: lesson,
        alreadyCompleted: alreadyCompleted,
      );
    //video
    case 3:
      return const SizedBox();
    //pract
    case 4:
      return PracticeLessonScreen(alreadyCompleted: alreadyCompleted, lesson: lesson,);
  }
  return const SizedBox();
}