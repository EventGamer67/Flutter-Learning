import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stas_learning_1/features/crypto_coins_list/crypto_list.dart';

void main() {
  runApp(const CryptoCurrencyTracker());
}

class CryptoCurrencyTracker extends StatelessWidget {
  const CryptoCurrencyTracker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 93, 0, 255),
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 93, 0, 255),
          brightness: Brightness.dark,
        ).inversePrimary),
        useMaterial3: true,
        listTileTheme: const ListTileThemeData(
          iconColor: Color.fromARGB(255, 93, 0, 255),
        ),
        textTheme: const TextTheme(
          titleMedium: TextStyle(fontFamily: "Montserrat"),
          labelSmall: TextStyle(fontFamily: "Montserrat"),
        ),
      ),
      routes: {
        '/': (context) => const CryptoListScreen(title: "dam"),
        '/Coin': (context) => const CryptoCoinScreen(),
      },
      initialRoute: '/',
    );
  }
}

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
