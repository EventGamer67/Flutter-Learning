// ignore_for_file: file_names

import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
    {required BuildContext context,
    required String message,
    required String yesText,
    required String noText,
    required String header}) async {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child:
        Text(noText, style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 16)),
    onPressed: () {
      // returnValue = false;
      Navigator.of(context).pop(false);
    },
  );
  Widget continueButton = ElevatedButton(
    child: Text(
      yesText,
      style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 16),
    ),
    onPressed: () {
      // returnValue = true;
      Navigator.of(context).pop(true);
    },
  ); // set up the AlertDialogs
  AlertDialog alert = AlertDialog(
    title:
        Text(header, style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 16)),
    content:
        Text(message, style: const TextStyle(fontFamily: 'Comic Sans', fontSize: 16)),
    actions: [
      cancelButton,
      continueButton,
    ],
  ); // show the dialog
  final result = await showDialog<bool?>(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return result ?? false;
}
