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
    GetIt.I.get<Talker>().critical(await Api().loadLessonTest(widget.lesson.id));
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
  final Map<String,dynamic> question;
  const TestTile({super.key, required this.question});

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {

  @override
  void initState() {
    super.initState();
    GetIt.I<Talker>().debug(widget.question);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
                color: const Color.fromARGB(255, 52, 152, 219), width: 2)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              Text(widget.question.keys.toString()),
              // Column(
              //     children: widget.answers.map((e) {
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 5),
              //     child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           borderRadius:
              //               const BorderRadius.all(Radius.circular(20)),
              //           border: Border.all(
              //             width: 2,
              //             color: const Color.fromARGB(255, 52, 152, 219),
              //           )),
              //       child: Padding(
              //         padding: const EdgeInsets.all(8.0),
              //         child: Text(e['text']),
              //       ),
              //     ),
              //   );
              // }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
