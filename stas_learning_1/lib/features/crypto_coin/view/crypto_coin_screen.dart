import 'dart:developer';
import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({
    super.key,
  });

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null) {
      log('You must provide args');
      return;
    }
    if (args is! String) {
      log('You must provide string args');
      return;
    }
    coinName = args;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
      ),
      bottomNavigationBar: const BottomAppBar(
        child: Text("sdf"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("some text"),
            ElevatedButton(
                onPressed: () {
                  log("tap");
                },
                child: const Text("tap chel"))
          ],
        ),
      ]),
    );
  }
}
