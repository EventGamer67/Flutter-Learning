import 'package:flutter/material.dart';
import 'package:stas_learning_1/router/router.dart';
import 'package:stas_learning_1/theme/theme.dart';

class CryptoCurrencyTracker extends StatelessWidget {
  const CryptoCurrencyTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      routes: routes,
    );
  }
}
