import 'package:flutter/material.dart';

final darkTheme = ThemeData(
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
);