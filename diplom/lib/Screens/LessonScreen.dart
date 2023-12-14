import 'dart:async';
import 'dart:convert';

import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

class LessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool completed;
  const LessonScreen(
      {super.key, required this.lesson, required this.completed});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    Widget selectedWidget;
    switch (widget.lesson.type) {
      case 1: //lection
        selectedWidget = const Placeholder();
        break;
      case 2: //test
        selectedWidget = const Placeholder();
        break;
      case 3: //video
        selectedWidget = const Placeholder();
        break;
      default:
        selectedWidget = const Placeholder();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.lesson.name.toString()),
      ),
      body: SafeArea(
        child: selectedWidget,
      ),
    );
  }
}

class ParsedLesson extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;
  const ParsedLesson(
      {super.key, required this.lesson, required this.alreadyCompleted});

  @override
  State<ParsedLesson> createState() => _ParsedLessonState();
}

class _ParsedLessonState extends State<ParsedLesson> {
  loadBloc loadbloc = loadBloc();
  List<Map<String, dynamic>> data = [];
  late final Timer timer;
  double progressBarValue = 1.0;

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  _lessonCompleted() async {
    GetIt.I.get<Talker>().debug("Completed");
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

  _loadJSON(int lessonID) async {
    data = await Api().getJsonPage(lessonID);
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
    _loadJSON(widget.lesson.id);
  }

  List<Widget> getPageWidgets() {
    List<Widget> widgets = [];
    for (var element in data) {
      final String type = element['type'];
      if (type == "text") {
        if (element['pointed'] != null) {
          widgets.add(Container(
            decoration: element['decorated'] != null
                ? BoxDecoration(
                    color: Colors.purple.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20)))
                : null,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: element['decorated'] != null
                  ? EdgeInsets.all(8)
                  : EdgeInsets.all(0),
              child: Row(
                children: [
                  element['pointed'] != null
                      ? Container(
                          margin: EdgeInsets.all(5),
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                        )
                      : Container(),
                  Text(
                    element['data'],
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      fontSize: (element['size'] != null
                          ? element['size'] as double
                          : 18.0),
                      fontWeight: (element['bold'] == 1
                          ? FontWeight.bold
                          : FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }
        if (element['pointed'] == null) {
          widgets.add(Container(
            decoration: element['decorated'] != null
                ? BoxDecoration(
                    color: Colors.purple.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(20)))
                : null,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: element['decorated'] != null
                  ? EdgeInsets.all(8)
                  : EdgeInsets.all(0),
              child: Text(
                element['data'],
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontSize: (element['size'] != null
                      ? element['size'] as double
                      : 18.0),
                  fontWeight: (element['bold'] == 1
                      ? FontWeight.bold
                      : FontWeight.normal),
                ),
              ),
            ),
          ));
        }
      }
      if (type == "photo") {
        widgets.add(SizedBox(
          height: 200,
          child: Image(image: NetworkImage(element['data'])),
        ));
      }
      if (type == "gap") {
        widgets.add(SizedBox(
          height: element['data'],
        ));
      }
      if (type == "test") {
        final dynamic rawData = element['data'];
        if (rawData is Map<String, dynamic>) {
          String header = rawData['Header'];
          List<dynamic> questions = rawData['Questions'];
          widgets.add(Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: Colors.blue, width: 2)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    header,
                    style: TextStyle(fontSize: 24),
                  ),
                  Column(
                    children: questions.map((value) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                                color: Colors.black.withAlpha(120), width: 2)),
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              "${value['text']}",
                              style: TextStyle(fontSize: 18),
                            )),
                      );
                    }).toList(),
                  ),
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          "Проверить",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      )),
                ],
              ),
            ),
          ));
        } else {
          print('Invalid data format: $rawData');
        }
      }
    }

    return widgets;
  }

  Widget _parsedPage() {
    return Column(
      children: [
        LinearProgressIndicator(color: Colors.green, value: progressBarValue),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: getPageWidgets(),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(widget.lesson.name),
      ),
      body: SafeArea(
        child: BlocBuilder(
            bloc: loadbloc,
            builder: (context, state) {
              if (state is Loaded) {
                return _parsedPage();
              } else if (state is Loading) {
                return Container(
                    child: const Center(
                  child: CircularProgressIndicator(),
                ));
              } else if (state is LoadFailedLoading) {
                return const Expanded(
                    child: Center(
                  child: Text("Load Failed"),
                ));
              }
              return const Text("fail");
            }),
      ),
    );
  }
}
