// ignore_for_file: prefer_const_constructors

import 'package:diplom/Services/Data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
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
                      Text(
                        'Описание курса: \n${widget.course.description}',
                        style:
                            TextStyle(fontSize: 18.0, fontFamily: 'Comic Sans'),
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var module = widget.course.modules[index];
                    return ExpansionTile(
                      title: Text(
                        "${index + 1}. ${module.moduleName}",
                        style: TextStyle(fontFamily: 'Comic Sans', fontSize: 20),
                      ),
                      children: module.lessons.map((lesson) {
                        return ListTile(
                          subtitle: Text(
                            lessonNames[lesson.type] ?? 'None',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontFamily: 'Comic Sans'),
                          ),
                          title: Text(
                            lesson.lessonName,
                            style: TextStyle(
                                color: Colors.black, fontFamily: 'Comic Sans'),
                          ),
                          // trailing: Icon(
                          //   Icons.check,
                          //   color: Colors.green,
                          // ),
                          leading:
                              Icon(Icons.school_outlined, color: Colors.blue),
                        );
                      }).toList(),
                    );
                  },
                  childCount: widget.course.modules.length,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 100,),)
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.all(30),
              child: GestureDetector(
                onTap: () {
                  showCupertinoDialog(
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
                              Navigator.of(context).pop(); // Закрыть окно
                            },
                            child: Text("Нет",
                                style: TextStyle(fontFamily: 'Comic Sans')),
                          ),
                          CupertinoDialogAction(
                            onPressed: () {
                              // Вызвать функцию для записи на курс

                              Navigator.of(context).pop(); // Закрыть окно
                            },
                            child: Text("Да",
                                style: TextStyle(fontFamily: 'Comic Sans')),
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
                      color: Color.fromARGB(255, 52, 152, 219),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: Text(
                      "Записаться",
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
