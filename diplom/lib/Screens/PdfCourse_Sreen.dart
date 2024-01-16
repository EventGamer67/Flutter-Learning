// ignore_for_file: file_names

import 'package:diplom/Services/blocs/loadBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFCourseScreen extends StatefulWidget {
  const PDFCourseScreen({super.key});

  @override
  State<PDFCourseScreen> createState() => _PDFCourseScreenState();
}

class _PDFCourseScreenState extends State<PDFCourseScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late final response;
  late final PdfPage page;
  late final loadBloc loadbloc;
  @override
  void initState() {
    super.initState();
    loadbloc = loadBloc();
    _loadPDF(
        "https://gaxlrywbsvtamlbizmjt.supabase.co/storage/v1/object/public/docs/lessons/1.pdf");
  }

  _loadPDF(String link) async {
    final String path = GetIt.I
        .get<Supabase>()
        .client
        .storage
        .from('docs')
        .getPublicUrl('lessons');
    GetIt.I.get<Talker>().debug(path);
    // final response = await GetIt.I
    //     .get<Supabase>()
    //     .client
    //     .storage
    //     .from(path+'/')
    //     .download('1.pdf');
    // GetIt.I.get<Talker>().debug(response);
    loadbloc.add(LoadLoaded());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder(
          bloc: loadbloc,
          builder: (context, state) {
            if (state is Loaded) {
              return Center(
                  child: SfPdfViewer.network(
                key: _pdfViewerKey,
                "https://gaxlrywbsvtamlbizmjt.supabase.co/storage/v1/object/public/docs/lessons/1.pdf",
                pageLayoutMode: PdfPageLayoutMode.single,
                
              ));
            } else if (state is Loading) {
              return const Center(
                child: Text("Loading"),
              );
            } else if (state is FailedLoading) {
              return const Center(
                child: Text("failed"),
              );
            }
            return const Text("Ошибка");
          },
        ));
  }
}
