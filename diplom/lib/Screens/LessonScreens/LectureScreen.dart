// ignore_for_file: file_names

import 'dart:async';

import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
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
  late final ScrollController _scrollController;
  
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
        progressBarValue += 0.01; // Update the progress bar value here
      } else {
        timer.cancel(); // Cancel the timer when progress reaches 100%
        _lessonCompleted();
      }
    });
  }

  _loadLesson() async {
  loadbloc = loadBloc();
  if (!widget.alreadyCompleted) {
    progressBarValue = 0;
    int totalCharacters = widget.lesson.text.length;
    int periodInSeconds = (totalCharacters / 200).ceil(); // Вычисляем общее время в секундах
    int timerPeriod = periodInSeconds * 1000; // Устанавливаем период таймера (10 раз в секунду)
    timer = Timer.periodic(const Duration(milliseconds: (1000 ~/ 10)), _updateProgress);
    Timer(Duration(seconds: periodInSeconds), () {
      timer.cancel(); // Отменяем таймер после указанного времени
      _lessonCompleted();
    });
  } else {
    timer = Timer(const Duration(seconds: 0), () {});
  }
  loadbloc.add(LoadLoaded());
}

  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {

          if( !GetIt.I.get<Data>().user.completedLessonsID.contains( widget.lesson.id) && !widget.alreadyCompleted){
            _lessonCompleted();
            setState(() {
              });
          }
      
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

  
    _loadLesson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(widget.lesson.name.toString(), style: TextStyle(fontFamily: 'Comic Sans'),),
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
                controller: _scrollController,
                child: Column(
                  children: [
                    Image.network(
                      widget.lesson.media,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Изображение загружается", style: TextStyle(fontFamily: 'Comic Sans')),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Ошибка загрузки изображения", style: TextStyle(fontFamily: 'Comic Sans')),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.lesson.text,
                        style: const TextStyle(fontSize: 18, fontFamily: 'Comic Sans'),
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
