import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/App.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:get_it/get_it.dart';

void main() async {
  
  final dio = Dio();
  GetIt.I.registerSingleton<Dio>(dio);
  final data = Data();
  GetIt.I.registerSingleton<Data>(data);

  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

 class MyHttpOverrides extends HttpOverrides{ 
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}