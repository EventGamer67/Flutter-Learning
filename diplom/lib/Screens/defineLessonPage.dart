// ignore_for_file: file_names

import 'dart:async';

import 'package:diplom/Screens/LessonScreens/LectureScreen.dart';
import 'package:diplom/Screens/LessonScreens/practiceScreen.dart';
import 'package:diplom/Screens/LessonScreens/testLessonScreen.dart';
import 'package:diplom/Services/Data.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget defineLessonPage(
    {required Lesson lesson, required bool alreadyCompleted}) {
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
      return VideoLessonScreen(
        lesson: lesson,
        alreadyCompleted: alreadyCompleted,
      );
    //pract
    case 4:
      return PracticeLessonScreen(
        alreadyCompleted: alreadyCompleted,
        lesson: lesson,
      );
  }
  return const SizedBox();
}

class VideoLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;

  const VideoLessonScreen(
      {super.key, required this.alreadyCompleted, required this.lesson});

  @override
  State<VideoLessonScreen> createState() => _VideoLessonScreenState();
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  late final Timer timer;
  double progressBarValue = 1.0;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _lessonCompleted() async {
    try {
      final respone = await GetIt.I
          .get<Supabase>()
          .client
          .from('LessonsProgress')
          .insert({
        'LessonID': widget.lesson.id,
        'UserID': GetIt.I.get<Data>().user.id
      }, defaultToNull: true);
      GetIt.I.get<Talker>().debug("sended $respone");
      GetIt.I.get<Data>().user.completedLessonsID.add(widget.lesson.id);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Пройдено")));
    } catch (err) {
      GetIt.I.get<Talker>().critical("sended fail $err");
    }
  }

  void _updateProgress(Timer timer) {
    setState(() {
      if (progressBarValue < 1.0) {
        progressBarValue += 0.1; // Update the progress bar value here
      } else {
        timer.cancel(); // Cancel the timer when progress reaches 100%
        _lessonCompleted();
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetIt.I.get<Talker>().critical(this.widget.alreadyCompleted);
    super.initState();
    if (!widget.alreadyCompleted) {
      progressBarValue = 0;
      timer = Timer.periodic(const Duration(seconds: 1), _updateProgress);
    } else {
      timer = Timer(const Duration(seconds: 0), () => null);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.lesson.name.toString()),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
                color: Colors.green, value: progressBarValue),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      widget.lesson.media,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Изображение загружается"),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Ошибка загрузки изображения"),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          launchUrlString(widget.lesson.text);
                        },
                        child: Text(
                          widget.lesson.text,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
