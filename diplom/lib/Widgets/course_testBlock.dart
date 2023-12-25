// ignore_for_file: file_names

import 'dart:convert';
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

  _questionChanged(int id) {
    page = id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: widget.tests.map((e) {
          GetIt.I.get<Talker>().good(e);
          final Map<String, dynamic> test = jsonDecode(e);
          // final List<dynamic> internalTests = test['questions'];
          final List<dynamic> internalTests = test['answers'];
          // List<TestTile> pagetests = internalTests
          //     .map((e) => TestTile(
          //           test: e,
          //           answers: e['answers'],
          //         ))
          //     .toList();

          return const Column(
            children: [
              // Text("Вопрос $page/${pagetests.length}"),
              // SizedBox(
              //     height: 300,
              //     child: PageView(
              //       controller: pageController,
              //       onPageChanged: _questionChanged,
              //       children: pagetests,
              //     )),
            ],
          );
        }).toList(),
      ),
    );
  }
}
