import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CourseTestBlock extends StatefulWidget {
  final List<dynamic> tests;
  const CourseTestBlock({super.key, required this.tests});

  @override
  State<CourseTestBlock> createState() => _CourseTestBlockState();
}

class _CourseTestBlockState extends State<CourseTestBlock> {
  late final PageController pageController;
  int page = 0;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  _questionChanged(int id){
    page = id;
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: widget.tests.map((e) {
            GetIt.I.get<Talker>().good(e);
            final Map<String, dynamic> test = jsonDecode(e);
            // final List<dynamic> internalTests = test['questions'];
            final List<dynamic> internalTests = test['answers'];
            List<TestTile> pagetests = internalTests
                .map((e) => TestTile(
                      test: e,
                      answers: e['answers'],
                    ))
                .toList();

            return Column(
              children: [
                Text("Вопрос ${page}/${pagetests.length}"),
                Container(
                    height: 300,
                    child: PageView(
                      children: pagetests,
                      controller: pageController,
                      onPageChanged: _questionChanged,
                    )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class TestTile extends StatefulWidget {
  final test;
  final List<dynamic> answers;
  const TestTile({super.key, required this.test, required this.answers});

  @override
  State<TestTile> createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {
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
              Text(widget.test['text']),
              Column(
                  children: widget.answers.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          width: 2,
                          color: const Color.fromARGB(255, 52, 152, 219),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(e['text']),
                    ),
                  ),
                );
              }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
