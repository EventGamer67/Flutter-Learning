// ignore_for_file: file_names

import 'package:flutter/material.dart';

IconData getFileIcon(String url) {
  String extension = url.split('.').last.toLowerCase();

  switch (extension) {
    case 'pdf':
      return Icons.picture_as_pdf;
    case 'png':
      return Icons.image;
    case 'jpg':
      return Icons.image;
    case 'doc':
      return Icons.description;
    case 'docx':
      return Icons.description;
    case 'pptx':
      return Icons.slideshow;
    case 'txt':
      return Icons.text_snippet;
    default:
      return Icons.insert_drive_file;
  }
}
