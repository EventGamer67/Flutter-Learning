import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});
  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
                thickness: 0.3,
              ),
          itemCount: 30,
          itemBuilder: (context, i) {
            const String coinName = 'BitCoin';
            return ListTile(
              leading: SvgPicture.asset(
                "assets/svg/token.svg",
                height: 35,
                width: 35,
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              title: Text(
                'BitCoin',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Text(
                "пошел нахуй",
                style: theme.textTheme.labelSmall,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/Coin', arguments: coinName);
              },
            );
          }),
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
    );
  }
}
