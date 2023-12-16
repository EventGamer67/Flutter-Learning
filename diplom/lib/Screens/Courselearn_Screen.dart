// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Models/DatabaseClasses/module.dart';
import 'package:diplom/Screens/LessonScreen.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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
                          shadows: const [
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
                            value: widget.course.progress,
                            minHeight: 40,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.black),
                          ),
                          Center(
                            child: Text(
                              'Прогресс ${(widget.course.progress * 100).floor()}%',
                              style: TextStyle(
                                  fontSize: 24.0,
                                  fontFamily: 'Comic Sans',
                                  shadows: [Shadow(color: Colors.black, blurRadius: 6)],
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          'Модули:',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(fontSize: 18.0, fontFamily: 'Comic Sans', ),
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
                                  onTap: () async {
                                    final lessonStateTypes =
                                        e.getLessonState(lessons);
                                    switch (lessonStateTypes) {
                                      case (LessonStateTypes.Current):
                                        // await Navigator.push(context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) {
                                        //   return ParsedLesson(
                                        //       lesson: e,
                                        //       alreadyCompleted: false);
                                        // }));
                                        // setState(() {});
                                        await Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LessonScreen(
                                              lesson: e,
                                              alreadyCompleted: false);
                                        }));
                                        double completedPercents = this
                                                .widget
                                                .course
                                                .getLessonCompleteCount() /
                                            this.widget.course.getLessonCount();
                                        this.widget.course.progress =
                                            completedPercents;
                                        setState(() {});
                                      case (LessonStateTypes.Blocked):
                                        () {};
                                      case (LessonStateTypes.Completed):
                                        // await Navigator.push(context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) {
                                        //   return ParsedLesson(
                                        //       lesson: e,
                                        //       alreadyCompleted: true);
                                        // }));
                                        await Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return LessonScreen(
                                              lesson: e,
                                              alreadyCompleted: true);
                                        }));
                                        setState(() {});
                                    }
                                    return;
                                  },
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
                                  trailing: LessonCompleteTypeWidget(
                                    LessonTypes: e.getLessonState(lessons),
                                  ),
                                  leading: e.getLessonTypeIcon()))
                              .toList(),
                        );
                      }).toList());
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
                child: SertificateWidget(course: widget.course),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

class SertificateWidget extends StatelessWidget {
  final Course course;
  const SertificateWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final bool opened = course.progress == 1 ? true : false;
    //final bool opened = true;
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                child: Center(
                    child: Text(
                  opened
                      ? "Ты можешь получить свой сертификат! \n Нажми для получения"
                      : "Еще немного до сертификата!",
                  style: TextStyle(fontFamily: 'Comic Sans', fontSize: 20),
                  textAlign: TextAlign.center,
                )),
              ),
              opened
                  ? OpenedCertificate(
                      courseName: course.name,
                      owner: GetIt.I.get<Data>().user.name,
                    )
                  : ClosedCertificate(),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}

class OpenedCertificate extends StatelessWidget {
  final String courseName;
  final String owner;
  const OpenedCertificate(
      {super.key, required this.courseName, required this.owner});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          String? result = await FilePicker.platform.getDirectoryPath();
          final ByteData imageData =
              await rootBundle.load('assets/SertificateBlank.png');
          final Uint8List imageBytes = imageData.buffer.asUint8List();
          final ttf = await fontFromAssetBundle('assets/Comic-Sans-MS.ttf');

          pw.MemoryImage image = pw.MemoryImage(imageBytes);

          if (result != null && result.isNotEmpty) {
            String savePath = result;
            DateTime now = DateTime.now();
            String time =
                "${now.year}.${now.month}.${now.day} ${now.hour}:${now.minute > 9 ? now.minute : "0${now.minute}"}";
            final pdf = pw.Document();
            pdf.addPage(
              pw.Page(
                pageFormat: PdfPageFormat.a4.landscape,
                build: (pw.Context context) {
                  return pw.FullPage(
                      ignoreMargins: true,
                      child: pw.Stack(children: [
                        pw.Image(image, fit: pw.BoxFit.cover),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(20),
                          child: pw.Stack(children: [
                            pw.Align(
                                alignment: pw.Alignment(-1, 0.15),
                                child: pw.Text(owner,
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        color: PdfColor.fromHex("4472c4"),
                                        fontSize: 48))),
                            pw.Align(
                                alignment: pw.Alignment(-1, -0.3),
                                child: pw.Container(
                                    width: 500,
                                    height: 200,
                                    child: pw.FittedBox(
                                      fit: pw.BoxFit.scaleDown,
                                        child: pw.Text(courseName,
                                            textAlign: pw.TextAlign.left,
                                            style: pw.TextStyle(
                                                font: ttf,
                                                color:
                                                    PdfColor.fromHex("4472c4"),
                                                fontSize: 48))))),
                            pw.Align(
                                alignment: pw.Alignment(-1, -1),
                                child: pw.Text(time,
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        color: PdfColor.fromHex("4472c4"),
                                        fontSize: 24))),
                            pw.Align(
                                alignment: pw.Alignment(0.98, -0.67),
                                child: pw.Container(
                                    width: 220,
                                    height: 220,
                                    child: pw.FittedBox(
                                        fit: pw.BoxFit.scaleDown,
                                        child: pw.Text(courseName,
                                            //softWrap: true,
                                            textAlign: pw.TextAlign.center,
                                            style: pw.TextStyle(
                                                font: ttf,
                                                color:
                                                    PdfColor.fromHex("4472c4"),
                                                fontSize: 80)))))
                          ]),
                        )
                      ]));
                },
              ),
            );

            final file = File("$savePath/3example.pdf");
            await file.writeAsBytes(await pdf.save());
            GetIt.I.get<Talker>().good("File saved at $savePath/example.pdf");

            // Display the PDF preview using the PDFViewer package
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return Scaffold(
                appBar: AppBar(title: Text('PDF Preview')),
                body: PdfPreview(
                  build: (format) => pdf.save(),
                ),
              );
            }));
          }
        } catch (err) {
          GetIt.I.get<Talker>().critical("$err");
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 3),
            image: DecorationImage(
                image: AssetImage('assets/Sertificate.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Stack(children: [
          AspectRatio(
            aspectRatio: 4 / 2.5,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 60),
              padding: EdgeInsets.all(20),
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Comic Sans', overflow: TextOverflow.fade),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class ClosedCertificate extends StatelessWidget {
  const ClosedCertificate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black.withAlpha(30),
          borderRadius: BorderRadius.all(Radius.circular(20))),
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
                  fontFamily: 'Comic Sans', overflow: TextOverflow.fade),
            ),
          ),
        ),
      ]),
    );
  }
}

class LessonCompleteTypeWidget extends StatelessWidget {
  final LessonStateTypes LessonTypes;

  const LessonCompleteTypeWidget({super.key, required this.LessonTypes});

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
          border: Border.all(color: Colors.black.withOpacity(0.3), width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.lock_outline_rounded,
          color: Colors.black.withOpacity(0.3),
          size: 40,
        ),
      );
    }
    return Container();
  }
}
