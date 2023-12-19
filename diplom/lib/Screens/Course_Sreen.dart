// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Models/DatabaseClasses/otherUser.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:diplom/Widgets/authorCourseTile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CourseScreen extends StatefulWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  List<Module> modules = [];
  List<Lesson> lessons = [];
  bool alreadyRegistered = false;
  loadBloc loadbloc = loadBloc();
  OtherUser? author = null;

  _loadModules() async {
    try {
      alreadyRegistered = await Api().userRegisteredToCourse(
          widget.course.id, GetIt.I.get<Data>().user.id);

      modules = await Api().loadModules(this.widget.course.id);
      author = await Api().getUser(this.widget.course.author);

      modules.sort(((a, b) {
        return a.name.compareTo(b.name);
      }));
      for (var module in modules) {
        lessons.addAll(await Api().loadLessons(module.id)
          ..sort(((a, b) {
            return a.name.compareTo(b.name);
          })));
      }
      loadbloc.add(LoadLoaded());
      setState(() {});
    } catch (err) {
      GetIt.I.get<Talker>().critical('Failed to load modules ${err}');
      loadbloc.add(LoadFailedLoading());
    }
  }

  _registerToCourse() async {
    bool registered = await Api().registerUserToCourse(widget.course.id);
    if (registered) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Успешно")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ошибка")));
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
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          widget.course.name,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Comic Sans',
                            shadows: const [
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
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Описание курса: \n${widget.course.description}',
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: 'Comic Sans'),
                        ),
                      ),
                      Divider(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
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
                          Column(
                              children: modules.map((e) {
                            final moduleLessons = lessons
                                .where((element) => element.moduleID == e.id);
                            return ExpansionTile(
                              title: Text(
                                e.name,
                                style: TextStyle(
                                    fontFamily: 'Comic Sans', fontSize: 20),
                              ),
                              children: moduleLessons
                                  .map((e) => ListTile(
                                        subtitle: Text(
                                          e.getLessonTypeName(),
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
                          }).toList()),
                          Divider(),
                          AuthorCourseTile(author: author!)
                        ],
                      );
                    } else if (state is Loading) {
                      return SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ));
                    } else if (state is FailedLoading) {
                      return SizedBox(
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
                child: SizedBox(
                  height: 100,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(30),
              child: GestureDetector(
                onTap: () {
                  alreadyRegistered
                      ? null
                      : showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return CupertinoAlertDialog(
                              title: Text(
                                "Хотите записаться на курс?",
                                style: TextStyle(fontFamily: 'Comic Sans'),
                              ),
                              actions: [
                                CupertinoDialogAction(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Нет",
                                      style:
                                          TextStyle(fontFamily: 'Comic Sans')),
                                ),
                                CupertinoDialogAction(
                                  onPressed: () async {
                                    await Api()
                                        .registerUserToCourse(widget.course.id);
                                    alreadyRegistered = true;
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                  child: Text("Да",
                                      style:
                                          TextStyle(fontFamily: 'Comic Sans')),
                                ),
                              ],
                            );
                          },
                        );
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: alreadyRegistered
                          ? Color.fromARGB(255, 52, 219, 96)
                          : Color.fromARGB(255, 52, 152, 219),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(
                      alreadyRegistered ? "Вы уже записаны" : "Записаться",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Comic Sans',
                          color: Colors.white,
                          fontSize: 22),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
