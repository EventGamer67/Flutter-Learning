// ignore_for_file: prefer_const_constructors

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/LessonTypes.dart';
import 'package:diplom/Screens/LessonTest_Screen.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CourseLearnScreen extends StatefulWidget {
  final Course course;

  const CourseLearnScreen({super.key, required this.course});

  @override
  State<CourseLearnScreen> createState() => _CourseLearnScreenState();
}

class _CourseLearnScreenState extends State<CourseLearnScreen> {
  List<Module> modules = [];
  List<Lesson> lessons = [];
  loadBloc loadbloc = loadBloc();

  _loadModules() async {
    try {
      modules = await Api().loadModules(this.widget.course.id);

      modules.sort(((a, b) {
        return a.moduleName.compareTo(b.moduleName);
      }));
      for (var module in modules) {
        lessons.addAll(await Api().loadLessons(module.id));
      }
      loadbloc.add(LoadLoaded());
      setState(() {});
    } catch (err) {
      GetIt.I.get<Talker>().critical('Failed to load modules ${err}');
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
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                snap: true,
                expandedHeight: 300.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.course.name,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Comic Sans',
                          shadows: [
                            Shadow(color: Colors.black, blurRadius: 40)
                          ],
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
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Stack(
                        children: [
                          LinearProgressIndicator(
                            color: Color.fromARGB(255, 52, 152, 219),
                            backgroundColor: Color.fromARGB(60, 43, 197, 244),
                            value: 0.74,
                            minHeight: 40,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                          Center(
                            child: Text(
                              'Прогресс 74%',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Comic Sans',
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
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
                          children: modules.map((e) {
                        final moduleLessons = lessons
                            .where((element) => element.moduleID == e.id);
                        return ExpansionTile(
                          title: Text(
                            e.moduleName,
                            style: TextStyle(
                                fontFamily: 'Comic Sans', fontSize: 20),
                          ),
                          children: moduleLessons
                              .map((e) => ListTile(
                                    subtitle: Text(
                                      lessonNames[e.type] ?? 'None',
                                      style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontFamily: 'Comic Sans'),
                                    ),
                                    title: Text(
                                      e.name,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Comic Sans'),
                                    ),
                                    leading: Icon(Icons.school_outlined,
                                        color: Colors.blue),
                                  ))
                              .toList(),
                        );
                      }).toList());
                    } else if (state is Loading) {
                      return Container(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else if (state is FailedLoading) {
                      return Container(
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
              // SliverList(
              //   delegate: SliverChildBuilderDelegate(
              //     (BuildContext context, int index) {
              //       var module = widget.course.modules[index];
              //       return ExpansionTile(
              //         title: Text(
              //           "${index + 1}. ${module.moduleName}",
              //           style:
              //               TextStyle(fontFamily: 'Comic Sans', fontSize: 18),
              //         ),
              //         children: module.lessons.map((lesson) {
              //           return ListTile(
              //             onTap: () {
              //               Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                       builder: (context) => LessonTestScreen()));
              //             },
              //             subtitle: Text(
              //               lessonNames[lesson.type] ?? 'None',
              //               style: TextStyle(
              //                   color: Colors.black.withOpacity(0.5),
              //                   fontFamily: 'Comic Sans'),
              //             ),
              //             title: Text(
              //               lesson.lessonName,
              //               style: TextStyle(
              //                   color: Colors.black,
              //                   fontFamily: 'Comic Sans',
              //                   fontSize: 20),
              //             ),
              //             trailing: LessonCompleteTypeWidget(
              //               LessonTypes: LessonStateTypes.Completed,
              //             ),
              //             leading:
              //                 Icon(Icons.school_outlined, color: Colors.blue),
              //           );
              //         }).toList(),
              //       );
              //     },
              //     childCount: widget.course.modules.length,
              //   ),
              // ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Container(
                            height: 60,
                            child: Center(
                                child: Text(
                              "Еще немного до сертификата!",
                              style: TextStyle(
                                  fontFamily: 'Comic Sans', fontSize: 20),
                            )),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withAlpha(30),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Stack(children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 20, 0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Icon(
                                    Icons.school_outlined,
                                    size: 80,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ),
                              AspectRatio(
                                aspectRatio: 4 / 2.5,
                                child: Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 60),
                                  padding: EdgeInsets.all(20),
                                  child: Text(
                                    "Ты отлично справляешься! \nПродолжай учиться для открытия сертификата!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Comic Sans',
                                        overflow: TextOverflow.fade),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class LessonCompleteTypeWidget extends StatelessWidget {
  final LessonStateTypes LessonTypes;

  const LessonCompleteTypeWidget(
      {super.key, required LessonStateTypes this.LessonTypes});

  @override
  Widget build(BuildContext context) {
    if (LessonTypes == LessonStateTypes.Current) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.arrow_right_rounded,
          color: Colors.blue,
          size: 40,
        ),
      );
    } else if (LessonTypes == LessonStateTypes.Completed) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.green, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.check,
          color: Colors.green,
          size: 40,
        ),
      );
    } else if (LessonTypes == LessonStateTypes.Blocked) {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.lock_outline_rounded,
          color: Colors.black,
          size: 40,
        ),
      );
    }
    return Container();
  }
}
