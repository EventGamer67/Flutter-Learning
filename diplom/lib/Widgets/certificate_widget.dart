import 'dart:io';
import 'package:diplom/Models/DatabaseClasses/course.dart';
import 'package:diplom/Services/Data.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:pdf/widgets.dart' as pw;


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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(
                child: Center(
                    child: Text(
                  opened
                      ? "Ты можешь получить свой сертификат! \n Нажми для получения"
                      : "Еще немного до сертификата!",
                  style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 20),
                  textAlign: TextAlign.center,
                )),
              ),
              opened
                  ? OpenedCertificate(
                      courseName: course.name,
                      owner: GetIt.I.get<Data>().user.name,
                    )
                  : const ClosedCertificate(),
            ],
          ),
        ),
        const SizedBox(
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
                          padding: const pw.EdgeInsets.all(20),
                          child: pw.Stack(children: [
                            pw.Align(
                                alignment: const pw.Alignment(-1, 0.15),
                                child: pw.Text(owner,
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        color: PdfColor.fromHex("4472c4"),
                                        fontSize: 48))),
                            pw.Align(
                                alignment: const pw.Alignment(-1, -0.3),
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
                                alignment: const pw.Alignment(-1, -1),
                                child: pw.Text(time,
                                    textAlign: pw.TextAlign.left,
                                    style: pw.TextStyle(
                                        font: ttf,
                                        color: PdfColor.fromHex("4472c4"),
                                        fontSize: 24))),
                            pw.Align(
                                alignment: const pw.Alignment(0.98, -0.67),
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
            GetIt.I.get<Talker>().good("here");
            final file = File("$savePath/3example.pdf");
            await file.writeAsBytes(await pdf.save());
            
            GetIt.I.get<Talker>().good("File saved at $savePath/example.pdf");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Сохранено")));
            // Display the PDF preview using the PDFViewer package
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            //   return Scaffold(
            //     appBar: AppBar(title: const Text('PDF Preview')),
            //     body: PdfPreview(
            //       build: (format) => pdf.save(),
            //     ),
            //   );
            // }));
          }
        } catch (err) {
          GetIt.I.get<Talker>().critical("$err");
        }
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blue, width: 3),
            image: const DecorationImage(
                image: AssetImage('assets/Sertificate.png'), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Stack(children: [
          AspectRatio(
            aspectRatio: 4 / 2.5,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 60),
              padding: const EdgeInsets.all(20),
              child: const Text(
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
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
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
            margin: const EdgeInsets.only(top: 60),
            padding: const EdgeInsets.all(20),
            child: const Text(
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
