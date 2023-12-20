// ignore_for_file: non_constant_identifier_names

import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TestLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;
  const TestLessonScreen(
      {super.key, required this.lesson, required this.alreadyCompleted});

  @override
  State<TestLessonScreen> createState() => _TestLessonScreenState();
}

class _TestLessonScreenState extends State<TestLessonScreen> {
  late final loadBloc loadbloc;
  List<dynamic> questions = [];

  @override
  void initState() {
    loadbloc = loadBloc();
    super.initState();
    _loadTest();
  }

  _loadTest() async {
    GetIt.I
        .get<Talker>()
        .critical(await Api().loadLessonTest(widget.lesson.id));
    questions = await Api().loadLessonTest(widget.lesson.id);
    loadbloc.add(LoadLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 60,
        backgroundColor:
            const Color.fromARGB(255, 52, 152, 219).withOpacity(0.6),
        title: Text(
          widget.lesson.name,
          style: const TextStyle(fontFamily: 'Comic Sans', color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<loadBloc, LoadStates>(
          bloc: loadbloc,
          builder: (context, state) {
            if (state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is Loaded) {
              return PageView(
                children: questions.map((e) => TestTile(question: e)).toList(),
              );
            } else if (state is FailedLoading) {
              return const Text('FailedLoad');
            }
            return const Text('err');
          },
        ),
      ),
    );
  }
}

class TestTile extends StatefulWidget {
  final Map<String, dynamic> question;
  const TestTile({Key? key, required this.question}) : super(key: key);

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
  late List<dynamic> answers;
  late String type;
  late List<AnswerTile> widgetAnswers;

  @override
  void initState() {
    super.initState();
    type = widget.question['type'];
    answers = List.from(widget.question['answers']);
    widgetAnswers = answers.map((e) {
      return AnswerTile(
        key: UniqueKey(),
        text: e['text'],
        id: e['id'],
        onTap: _answerTileTapped,
        selected: false,
      );
    }).toList();
  }

  void _answerTileTapped(int id) {
    setState(() {
      if (type == 'single') {
        widgetAnswers = widgetAnswers.map((e) {
          return e.id == id
              ? e.copyWith(selected: true)
              : e.copyWith(selected: false);
        }).toList();
      } else if (type == 'multiple') {
        widgetAnswers = widgetAnswers.map((e) {
          return e.id == id ? e.copyWith(selected: !e.selected) : e;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color.fromARGB(255, 52, 152, 219),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(widget.question['text']),
              Text(type),
              Column(children: widgetAnswers),
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerTile extends StatelessWidget {
  final Function(int id) onTap;
  final int id;
  final String text;
  final bool selected;

  AnswerTile copyWith({
    Function(int id)? onTap,
    int? id,
    String? text,
    bool? selected,
  }) {
    return AnswerTile(
      key: key ?? UniqueKey(),
      onTap: onTap ?? this.onTap,
      id: id ?? this.id,
      text: text ?? this.text,
      selected: selected ?? this.selected,
    );
  }

  const AnswerTile({
    required Key key,
    required this.onTap,
    required this.id,
    required this.text,
    required this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call(id);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              width: 2,
              color: selected
                  ? Colors.green
                  : const Color.fromARGB(255, 52, 152, 219),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
