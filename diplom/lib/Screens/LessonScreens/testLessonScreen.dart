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
  const TestTile({super.key, required this.question});

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
  List<dynamic> answers = [];
  String type = '';

  List<AnswerTile> widgetAnswers = [];

  @override
  void initState() {
    super.initState();
    type = widget.question['type'];
    answers = widget.question['answers'];
    widgetAnswers = answers.map((e) {
      return AnswerTile(
        key: UniqueKey(),
        text: e['text'],
        id: e['id'],
        onTap: _AnswerTileTapped,
        selecteasd: false,
      );
    }).toList();
  }

  _AnswerTileTapped(int id) {
  if (type == 'single') {
      for (var element in widgetAnswers.where((element) => element.id != id)) {
        element.selecteasd = false;
      }
  } else if (type == 'multiple') {

  }
  setState(() {
    
  });
}

  @override
  Widget build(BuildContext context) {
    GetIt.I.get<Talker>().good("rebuild");
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: const Color.fromARGB(255, 52, 152, 219), width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(widget.question['text']),
              Text(type),
              Column(children: widgetAnswers)
            ],
          ),
        ),
      ),
    );
  }
}

class AnswerTile extends StatefulWidget {
  final Function(int id) onTap;
  final int id;
  final String text;
  bool selecteasd = false;
  AnswerTile(
      {
      required Key? key,
      required this.onTap,
      required this.id,
      required this.text,
      required this.selecteasd}):super(key:key);

  @override
  State<AnswerTile> createState() => _AnswerTileState();
}

class _AnswerTileState extends State<AnswerTile> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    selected = this.widget.selecteasd;
    GetIt.I.get<Talker>().critical("${this.widget.id} updated selected ${this.selected} final  ${this.widget.selecteasd} ");
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTap.call(widget.id);
          this.widget.selecteasd = !this.widget.selecteasd;
        });
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
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}
