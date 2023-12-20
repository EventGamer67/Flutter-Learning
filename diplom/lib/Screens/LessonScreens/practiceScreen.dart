// ignore_for_file: file_names

import 'dart:io';
import 'package:diplom/Models/DatabaseClasses/pdfLesson.dart';
import 'package:diplom/Models/DatabaseClasses/practice.dart';
import 'package:diplom/Models/DatabaseClasses/userPractice.dart';
import 'package:diplom/Services/Api.dart';
import 'package:diplom/Services/Data.dart';
import 'package:diplom/Services/Tools.dart';
import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:url_launcher/url_launcher.dart';

class PracticeLessonScreen extends StatefulWidget {
  final Lesson lesson;
  final bool alreadyCompleted;

  const PracticeLessonScreen(
      {super.key, required this.alreadyCompleted, required this.lesson});

  @override
  State<PracticeLessonScreen> createState() => _PracticeLessonScreenState();
}

class _PracticeLessonScreenState extends State<PracticeLessonScreen> {
  late final loadBloc loadbloc;
  List<PDFLesson> pdfs = [];
  List<Practise> practices = [];
  bool alreadySended = false;

  @override
  void initState() {
    super.initState();
    //_showAboutDialog();
    loadbloc = loadBloc();
    _loadPDFS();
  }

  _loadPDFS() async {
    pdfs = await Api().loadPDFSLesson(widget.lesson.id);
    practices = await Api().loadPractices(widget.lesson.id);
    GetIt.I<Talker>().critical(practices);
    loadbloc.add(LoadLoaded());
  }

  // _showAboutDialog() {
  //   Future.delayed(const Duration(seconds: 1), () {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Center(
  //             child: Column(
  //               children: [
  //                 Text(widget.lesson.name),
  //                 AspectRatio(
  //                     aspectRatio: 16 / 9,
  //                     child: Image.network(widget.lesson.media)),
  //                 Text(widget.lesson.text),
  //                 Container(
  //                   decoration: const BoxDecoration(
  //                       color: Colors.red,
  //                       borderRadius: BorderRadius.all(Radius.circular(20))),
  //                   child: const Center(
  //                     child: Text("ok"),
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              widget.lesson.name.toString(),
              style: const TextStyle(fontFamily: 'Comic Sans'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
                color: Colors.green, value: widget.alreadyCompleted ? 1 : 0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.network(
                      widget.lesson.media,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Изображение загружается",
                                style: TextStyle(fontFamily: 'Comic Sans')),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          height: 30,
                          child: Center(
                            child: Text("Ошибка загрузки изображения",
                                style: TextStyle(fontFamily: 'Comic Sans')),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.lesson.text,
                        style: const TextStyle(
                            fontSize: 18, fontFamily: 'Comic Sans'),
                      ),
                    ),
                    BlocBuilder(
                        bloc: loadbloc,
                        builder: (context, state) {
                          if (state is Loading) {
                            return const SizedBox(
                              height: 300,
                              child: Center(child: Text("Loading")),
                            );
                          } else if (state is LoadFailedLoading) {
                            return const SizedBox(
                              height: 300,
                              child:
                                  Center(child: Text("Loading failed")),
                            );
                          } else if (state is Loaded) {
                            return PDFPracticeLessonBloc(
                              pdfs: pdfs,
                            );
                          }
                          return const Text("err");
                        }),
                    BlocBuilder(
                        bloc: loadbloc,
                        builder: (context, state) {
                          if (state is Loading) {
                            return const SizedBox(
                              height: 300,
                              child: Center(child: Text("Loading")),
                            );
                          } else if (state is LoadFailedLoading) {
                            return const SizedBox(
                              height: 300,
                              child:
                                  Center(child: Text("Loading failed")),
                            );
                          } else if (state is Loaded) {
                            return practices.isNotEmpty
                                ? PracticeLessonBlock(
                                    practices: practices,
                                    lesson: widget.lesson.id,
                                  )
                                : const SizedBox();
                          }
                          return const Text("err");
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PracticeLessonBlock extends StatefulWidget {
  final List<Practise> practices;
  final int lesson;
  const PracticeLessonBlock(
      {super.key, required this.practices, required this.lesson});

  @override
  State<PracticeLessonBlock> createState() => _PracticeLessonBlockState();
}

class _PracticeLessonBlockState extends State<PracticeLessonBlock> {
  late final Practise practise;
  late final TextEditingController _editingController;
  List<UserPractice> sendedPractices = [];
  bool sended = false;
  List<String> files = [];
  late final loadBloc loadbloc;

  @override
  void initState() {
    loadbloc = loadBloc();
    practise = widget.practices[0];
    _editingController = TextEditingController(text: "");
    _loadSendedPractices();
    super.initState();
  }

  _loadSendedPractices() async {
    sendedPractices = await Api().loadUserPractices(widget.lesson);
    sended = sendedPractices.isEmpty ? false : true;
    if (sended) {
      _editingController.text = sendedPractices[0].text;
    }
    loadbloc.add(LoadLoaded());
  }

  _loadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        files.addAll(result.paths.map((path) => path!));
      });
    }
  }

  uploadFilesToBucket({required List<String> files}) async {
    final Supabase supabase = GetIt.I<Supabase>();
    int iteration = 0;
    List<String> uploadedFiles = [];
    try {
      for (String filePath in files) {
        // Открываем файл для чтения¸

        // Загружаем файл в bucket
        var response = await supabase.client.storage.from('docs/practices').upload(
            'User-${GetIt.I.get<Data>().user.id}-${widget.lesson}-$iteration-${DateTime.now()}',
            File(filePath));
        GetIt.I.get<Talker>().good(response);
        uploadedFiles.add(filePath.split('/').last);
        iteration++;
      }
      GetIt.I.get<Talker>().debug(uploadedFiles.toString());
      await supabase.client.from('UserPractices').insert({
        'user': '${GetIt.I.get<Data>().user.id}',
        'lesson': '${widget.lesson}',
        'text': _editingController.text,
        'fileLinks': uploadedFiles
            .toString()
            .substring(1, uploadedFiles.toString().length - 1)
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Отправлено")));
      sendedPractices.add(UserPractice(
          id: -1,
          user: GetIt.I.get<Data>().user.id,
          lesson: widget.lesson,
          text: _editingController.text,
          fileLinks: uploadedFiles
              .toString()
              .substring(1, uploadedFiles.toString().length - 1)));
      setState(() {
        sended = true;
      });
    } catch (error) {
      GetIt.I.get<Talker>().critical(error);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ошибка: $error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: loadbloc,
      builder: (context, state) {
        return sended
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              "Задание прикреплено, ожидайте проверки",
                              style: TextStyle(fontFamily: 'Comic Sans'))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ваш отправленный ответ",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color:
                                        const Color.fromARGB(255, 52, 152, 219)
                                            .withOpacity(0.3)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: EditableText(
                                  controller: _editingController,
                                  readOnly: true,
                                  focusNode: FocusNode(),
                                  expands: true,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor:
                                      const Color.fromARGB(255, 52, 152, 219),
                                  backgroundCursorColor: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: sendedPractices[0].fileLinks.isNotEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text("Ваши прикрепленные файлы:"),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: sendedPractices[0]
                                                .fileLinks
                                                .split(',')
                                                .map((e) => Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        e.split('/').last,
                                                        maxLines: 1,
                                                      ),
                                                    ))
                                                .toList()),
                                      ],
                                    )
                                  : const SizedBox()),
                        ],
                      )
                    ]),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("Прикрепите задание",
                              style: TextStyle(fontFamily: 'Comic Sans'))),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ваш ответ",
                            style: TextStyle(fontFamily: 'Comic Sans'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        255, 52, 152, 219)),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: EditableText(
                                  controller: _editingController,
                                  focusNode: FocusNode(),
                                  expands: true,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor:
                                      const Color.fromARGB(255, 52, 152, 219),
                                  backgroundCursorColor: Colors.black),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                              child: files.isNotEmpty
                                  ? Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: const Text("Ваши файлы:"),
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: files
                                                .map((e) => Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        e.split('/').last,
                                                        maxLines: 1,
                                                      ),
                                                    ))
                                                .toList()),
                                      ],
                                    )
                                  : const SizedBox()),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _loadFile();
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 52, 152, 219),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.add_a_photo_outlined,
                                          size: 36, color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              uploadFilesToBucket.call(files: files);
                            },
                            child: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  color: Color.fromARGB(255, 52, 152, 219)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Send",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Comic Sans'),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ]),
              );
      },
    );
  }
}

class PDFPracticeLessonBloc extends StatelessWidget {
  final List<PDFLesson> pdfs;
  const PDFPracticeLessonBloc({super.key, required this.pdfs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            alignment: Alignment.centerLeft,
            child: const Text("Прикрепленные файлы к уроку",
                style: TextStyle(fontFamily: 'Comic Sans'))),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pdfs.map((e) => PDFfileTile(file: e)).toList(),
        )
      ]),
    );
  }
}

class PDFfileTile extends StatelessWidget {
  final PDFLesson file;
  const PDFfileTile({super.key, required this.file});

  _openFile() async {
    // Предположим, что pdf.nameFile содержит URL для скачивания файла
    String url = file.pdfLink;

    // Получаем директорию для сохранения файла
    //Directory? appDocDir = await getApplicationDocumentsDirectory();
    //String filePath = '${appDocDir.path}/myFile.pdf';

    // Скачиваем файл
    // await launch(
    //   url, headers: {},
    //   // Используем метод GET для скачивания файла
    //   // Это может отличаться в зависимости от вашего API для загрузки файлов
    //   // Убедитесь, что ваш сервер поддерживает загрузку файлов с помощью GET-запросов
    //   forceSafariVC: false,
    //   forceWebView: false,
    // );

    await launchUrl(Uri.parse(url), mode:LaunchMode.platformDefault);

    // Открываем файл после его скачивания
    // В зависимости от типа файла и настроек устройства, можно использовать различные плагины
    // Для открытия PDF можно использовать, например, пакет flutter_pdfview
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: GestureDetector(
        onTap: () {
          _openFile();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  width: 2, color: const Color.fromARGB(255, 52, 152, 219))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  getFileIcon(file.pdfLink),
                  color: const Color.fromARGB(255, 52, 152, 219),
                  size: 30,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  file.nameFile,
                  style: const TextStyle(fontFamily: 'Comic Sans'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}