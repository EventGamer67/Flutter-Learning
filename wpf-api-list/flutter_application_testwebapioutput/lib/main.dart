import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/App.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() async {
  
  final dio = Dio();
  getIt.registerSingleton<Dio>(dio); // Register Dio as singleton

  final data = Data();
  getIt.registerSingleton<Data>(data); // Register ProductsData as singleton of type Data

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