// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:diplom/Widgets/yesNoDialog.dart';
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
  late final PageController _pageController;
  double progress = 0;
  int currentPage = 0;
  List<dynamic> questions = [];
  List<List<int>> choosedAnswers = [];

  _pageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  _completeTest() {
    final int correctAnswers = 0;
    int iteration = 0;
    double correct = 0;
    for (var quest in questions) {
      final answers = choosedAnswers[iteration];
      final List<int> corrects = List<int>.from(quest['corrects']);
      GetIt.I.get<Talker>().good(corrects);
      GetIt.I.get<Talker>().good(answers);
      if (quest['type'] == 'multiple') {
        if (corrects.length == answers.length &&
            corrects.every((element) => answers.contains(element))) {
          GetIt.I.get<Talker>().good("all corrects");
          correct += 1;
        } else {
          GetIt.I.get<Talker>().critical("smth wrong");
        }
      } else if (quest['type'] == 'single') {
        if (corrects.length == answers.length &&
            corrects.every((element) => answers.contains(element))) {
          GetIt.I.get<Talker>().good("all corrects");
          correct += 1;
        } else {
          GetIt.I.get<Talker>().critical("smth wrong");
        }
      }
      iteration++;
    }

    if (correct == questions.length) {
      Api().completetest(widget.lesson.id, GetIt.I.get<Data>().user.id);
    }
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TestResultScreen(
                  count: questions.length.toDouble(),
                  corrects: correct,
                )));
  }

  @override
  void initState() {
    loadbloc = loadBloc();
    _pageController = PageController();
    super.initState();
    _loadTest();
  }

  _loadTest() async {
    questions = await Api().loadLessonTest(widget.lesson.id);
    choosedAnswers = List.generate(questions.length, (index) => []);
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
              int iteration = 0;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                            color: Colors.green,
                            minHeight: 10,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            value: currentPage / (questions.length - 1)),
                      )
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: PageView(
                        onPageChanged: (value) {
                          _pageChanged(value);
                        },
                        controller: _pageController,
                        children: [
                          for (var e in questions)
                            TestTile(
                                question: e,
                                choosedAnswersQuestion:
                                    choosedAnswers[iteration++])
                        ]
                        //children: questions.map((e) => TestTile(question: e, choosedAnswersQuestion: [] ,)).toList(),
                        ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () async {
                        if (currentPage == questions.length - 1) {
                          final bool res = await showAlertDialog(
                              header: 'Внимание',
                              message: 'Завершить тест?',
                              context: context,
                              noText: 'Нет',
                              yesText: 'Завершить');
                          if (res) {
                            _completeTest();
                          }
                        } else {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutCirc);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: currentPage == questions.length - 1
                                ? Colors.green
                                : const Color.fromARGB(255, 52, 152, 219),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        height: 60,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: currentPage == questions.length - 1
                              ? const Text(
                                  "Завершить",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Comic Sans'),
                                )
                              : const Text(
                                  "Далее",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontFamily: 'Comic Sans'),
                                ),
                        )),
                      ),
                    ),
                  ),
                ],
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
  List<int> choosedAnswersQuestion;
  TestTile(
      {Key? key, required this.question, required this.choosedAnswersQuestion})
      : super(key: key);

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
        selected: widget.choosedAnswersQuestion.contains(e['id']),
      );
    }).toList();
  }

  void _answerTileTapped(int id) {
    setState(() {
      if (type == 'single') {
        widget.choosedAnswersQuestion.clear();
        widget.choosedAnswersQuestion.add(id);
        widgetAnswers = widgetAnswers.map((e) {
          return e.id == id
              ? e.copyWith(selected: true)
              : e.copyWith(selected: false);
        }).toList();
      } else if (type == 'multiple') {
        if (widget.choosedAnswersQuestion.contains(id)) {
          widget.choosedAnswersQuestion.remove(id);
        } else {
          widget.choosedAnswersQuestion.add(id);
        }
        widgetAnswers = widgetAnswers.map((e) {
          return e.id == id ? e.copyWith(selected: !e.selected) : e;
        }).toList();
      }
    });
    GetIt.I.get<Talker>().debug(widget.choosedAnswersQuestion);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   borderRadius: const BorderRadius.all(Radius.circular(20)),
        //   border: Border.all(
        //     color: const Color.fromARGB(255, 52, 152, 219),
        //     width: 2,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.question['text']),
                Text(type),
                Column(children: widgetAnswers),
              ],
            ),
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

class TestResultScreen extends StatefulWidget {
  final double count;
  final double corrects;
  const TestResultScreen(
      {super.key, required this.corrects, required this.count});
  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Завершение теста'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Тест завершен',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
          const Text(
            'Название теста',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Stack(children: [
            SizedBox(
                width: 100,
                height: 100,
                child: Icon(
                  Icons.school_rounded,
                  color: widget.corrects == widget.count
                      ? Colors.blue
                      : Colors.red,
                  size: 52,
                )),
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                value: widget.corrects / widget.count,
                color:
                    widget.corrects == widget.count ? Colors.blue : Colors.red,
                backgroundColor: widget.corrects == widget.count
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.red.withOpacity(0.3),
              ),
            ),
          ]),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Text(
              '${widget.corrects}/${widget.count}',
              style: const TextStyle(fontSize: 36),
            ),
          ),
          widget.corrects == widget.count
              ? const Center(
                  child: Text(
                    'Тест завершен',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : const Center(
                  child: Text(
                    'Тест провален',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: GestureDetector(
              onTap: () {
                GetIt.I.get<Talker>().debug("clicked");
                Navigator.pop(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Хорошо',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
