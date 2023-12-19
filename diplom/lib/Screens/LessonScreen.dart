import 'dart:async';

import 'package:diplom/Screens/LessonScreens/LectureScreen.dart';
import 'package:diplom/Screens/LessonScreens/practiceScreen.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
      return LessonScreen(
        lesson: lesson,
        alreadyCompleted: alreadyCompleted,
      );
    //video
    case 3:
      return SizedBox();
    //pract
    case 4:
      return PracticeLessonScreen(alreadyCompleted: alreadyCompleted, lesson: lesson,);
  }
  return SizedBox();
}

class DefineLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;
  final LessonType lessonType;
  const DefineLessonScreen(
      {super.key,
      required this.lesson,
      required this.alreadyCompleted,
      required this.lessonType});

  @override
  State<DefineLessonScreen> createState() => _DefineLessonScreenState();
}

class _DefineLessonScreenState extends State<DefineLessonScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.header,
    required this.questions,
  });

  final String header;
  final List questions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              header,
              style: const TextStyle(fontSize: 24),
            ),
            Column(
              children: questions.map((value) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Colors.black.withAlpha(120), width: 2)),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${value['text']}",
                        style: const TextStyle(fontSize: 18),
                      )),
                );
              }).toList(),
            ),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Проверить",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
