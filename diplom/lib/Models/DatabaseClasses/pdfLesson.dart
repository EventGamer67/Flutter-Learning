// ignore_for_file: file_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PDFLesson {
  int id;
  String pdfLink;
  int idLesson;
  String nameFile;
  PDFLesson({
    required this.id,
    required this.pdfLink,
    required this.idLesson,
    required this.nameFile,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pdfLink': pdfLink,
      'idLesson': idLesson,
      'nameFile': nameFile,
    };
  }

  factory PDFLesson.fromMap(Map<String, dynamic> map) {
    return PDFLesson(
      id: map['id'] as int,
      pdfLink: map['pdfLink'] as String,
      idLesson: map['idLesson'] as int,
      nameFile: map['nameFile'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PDFLesson.fromJson(String source) => PDFLesson.fromMap(json.decode(source) as Map<String, dynamic>);
}
