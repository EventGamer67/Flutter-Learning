// ignore_for_file: file_names

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Screens/defineLessonPage.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:diplom/Widgets/certificate_widget.dart';
import 'package:diplom/Widgets/course_stats_tile.dart';
import 'package:diplom/Widgets/lessonCompleteType_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CourseLearnScreen extends StatefulWidget {
  final Course course;

  const CourseLearnScreen({
    super.key,
    required this.course,
  });

  @override
  State<CourseLearnScreen> createState() => _CourseLearnScreenState();
}

class _CourseLearnScreenState extends State<CourseLearnScreen> {
  List<Module> modules = [];
  List<Lesson> lessons = [];
  loadBloc loadbloc = loadBloc();
  bool? canOpen = false;

  _loadModules() async {
    try {
      modules = await Api().loadModules(widget.course.id);
      modules.sort(((a, b) {
        return a.name.compareTo(b.name);
      }));
      for (var module in modules) {
        lessons.addAll(await Api().loadLessons(module.id)
          ..sort(((a, b) {
            return a.id.compareTo(b.id);
          })));
      }
      loadbloc.add(LoadLoaded());
      setState(() {});
    } catch (err) {
      GetIt.I.get<Talker>().critical('Failed to load modules $err');
      loadbloc.add(LoadFailedLoading());
    }
  }

  @override
  void initState() {
    super.initState();
    _loadModules();
  }

  @override
  Widget build(BuildContext context) {
    GetIt.I.get<Talker>().debug(widget.course.progress);
    return Scaffold(
      body: Container(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.course.name,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'Comic Sans',
                            shadows: [
                              Shadow(color: Colors.black, blurRadius: 40)
                            ],
                          ),
                        ),
                      )),
                  background: Image.network(
                    widget.course.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          LinearProgressIndicator(
                            color: const Color.fromARGB(255, 52, 152, 219),
                            backgroundColor:
                                const Color.fromARGB(60, 43, 197, 244),
                            value: widget.course.progress,
                            minHeight: 40,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                          Center(
                            child: Text(
                              'Прогресс ${(widget.course.progress * 100).floor()}%',
                              style: const TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Comic Sans',
                                  shadows: [
                                    Shadow(color: Colors.black, blurRadius: 6)
                                  ],
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: const Text(
                          'Модули:',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Comic Sans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder(
                  bloc: loadbloc,
                  builder: (context, state) {
                    if (state is Loaded) {
                      return Column(
                        children: [
                          CourseStateTile(
                            course: widget.course,
                            lessons: lessons,
                          ),
                          Column(
                              children: modules.map((e) {
                            final moduleLessons = lessons
                                .where((element) => element.moduleID == e.id);
                            return ExpansionTile(
                              title: Text(
                                e.name,
                                style: const TextStyle(
                                    fontFamily: 'Comic Sans', fontSize: 20),
                              ),
                              children: moduleLessons
                                  .map((e) => ListTile(
                                      onTap: () async {
                                        final lessonStateTypes =
                                            e.getLessonState(lessons);
                                        switch (lessonStateTypes) {
                                          case (LessonStateTypes.Current):
                                            await Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return defineLessonPage(
                                                  lesson: e,
                                                  alreadyCompleted: false);
                                            }));
                                            double completedPercents = widget
                                                    .course
                                                    .getLessonCompleteCount() /
                                                widget.course.getLessonCount();
                                            widget.course.progress =
                                                completedPercents;
                                            setState(() {});
                                          case (LessonStateTypes.Blocked):
                                            () {};
                                          case (LessonStateTypes.Completed):
                                            await Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return defineLessonPage(
                                                  lesson: e,
                                                  alreadyCompleted: true);
                                            }));
                                            double completedPercents = widget
                                                    .course
                                                    .getLessonCompleteCount() /
                                                widget.course.getLessonCount();
                                            widget.course.progress =
                                                completedPercents;
                                            setState(() {});
                                        }
                                        return;
                                      },
                                      subtitle: Text(
                                        e.getLessonTypeName(),
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            fontFamily: 'Comic Sans'),
                                      ),
                                      title: Text(
                                        e.name,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Comic Sans'),
                                      ),
                                      trailing: LessonCompleteTypeWidget(
                                        LessonTypes: e.getLessonState(lessons),
                                      ),
                                      leading: Icon(
                                        e.getLessonTypeIcon(),
                                        color: const Color.fromARGB(
                                            255, 52, 152, 219),
                                      )))
                                  .toList(),
                            );
                          }).toList()),
                        ],
                      );
                    } else if (state is Loading) {
                      return const SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else if (state is FailedLoading) {
                      return const SizedBox(
                        width: double.infinity,
                        height: 100,
                        child: Center(
                          child: Text(
                            "Failed load",
                            style: TextStyle(
                                fontFamily: 'Comic Sans', fontSize: 20),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: SertificateWidget(course: widget.course),
              )
            ],
          ),
        ]),
      ),
    );
  }
}


                                            // await Navigator.push(context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) {
                                            //   return ParsedLesson(
                                            //       lesson: e,
                                            //       alreadyCompleted: false);
                                            // }));
                                            // setState(() {});