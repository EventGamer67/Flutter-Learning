
import 'package:flutter/material.dart';
import 'package:flutter_calculator/Screens/onboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter_calculator/Services/api.dart';
import 'package:flutter_calculator/Services/data.dart';
import 'package:get_it/get_it.dart';

void main() {
  final dio = Dio();
  //dio.options.headers["Access-Control-Allow-Origin"] = "*";
  GetIt.I.registerSingleton<Dio>(dio);

  final data = Data();
  GetIt.I.registerSingleton<Data>(data);

  final api = Api();
  GetIt.I.registerSingleton<Api>(api);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnBoardWindow(),
      //home: const MainWindow(),
      //home: const RegistrationWindow(),
    );
  }
}