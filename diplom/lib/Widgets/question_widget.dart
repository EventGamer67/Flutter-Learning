import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({
    super.key,
    required this.header,
    required this.questions,
  });

  final String header;
  final List questions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.blue, width: 2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              header,
              style: const TextStyle(fontSize: 24),
            ),
            Column(
              children: questions.map((value) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                          color: Colors.black.withAlpha(120), width: 2)),
                  child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "${value['text']}",
                        style: const TextStyle(fontSize: 18),
                      )),
                );
              }).toList(),
            ),
            Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "Проверить",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
