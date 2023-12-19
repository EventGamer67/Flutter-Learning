
import 'dart:async';

import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:diplom/Widgets/course_testBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;
  const LessonScreen(
      {super.key, required this.lesson, required this.alreadyCompleted});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late final Timer timer;
  double progressBarValue = 1.0;
  late final loadBloc loadbloc;
  List<dynamic> tests = [];

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

  _loadlesson() async {
    loadbloc = loadBloc();

    final response = await Api().loadLessonTest(this.widget.lesson.id);

    for (var el in response) {
      tests.add(el['data']);
    }

    if (!widget.alreadyCompleted) {
      progressBarValue = 0;
      timer = Timer.periodic(const Duration(seconds: 1), _updateProgress);
    } else {
      timer = Timer(const Duration(seconds: 0), () => null);
    }
    loadbloc.add(LoadLoaded());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadlesson();
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
                      child: Text(
                        widget.lesson.text,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    BlocBuilder(
                        bloc: loadbloc,
                        builder: (context, state) {
                          if (state is Loaded) {
                            return CourseTestBlock(tests: tests);
                          } else if (state is Loading) {
                            return Text("Loading");
                          } else if (state is FailedLoading) {
                            return Text("failed load");
                          }
                          return Text("Exception");
                        }),
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