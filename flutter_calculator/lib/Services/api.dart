import 'package:dio/dio.dart';
import 'package:flutter_calculator/models/Feeling_model.dart';
import 'package:flutter_calculator/models/Quote_model.dart';
import 'package:get_it/get_it.dart';

class Api {
  String feelingsURL = "http://mskko2021.mad.hakta.pro/api/feelings";
  String quotesURL = "http://mskko2021.mad.hakta.pro/api/quotes";

  Future<List<Feeling>> getFeelings() async {
    try {
      Dio dio = GetIt.I.get<Dio>();

      final response = await dio.get(feelingsURL);

      Map<String, dynamic> dataRaw = response.data;

      List<dynamic> feelingsarray = dataRaw["data"];

      List<Feeling> feelings = [];

      feelingsarray.forEach((element) {
        feelings.add(Feeling.fromJson(element));
      });

      return feelings;
    } catch (err) {
      print(err);
      return [];
    }
  }

  Future<List<Quote>> getQuotes() async {
    try {
      Dio dio = GetIt.I.get<Dio>();

      final response = await dio.get(quotesURL);

      Map<String, dynamic> dataRaw = response.data;

      List<dynamic> quotesarray = dataRaw["data"];

      List<Quote> quotes = [];

      quotesarray.forEach((element) {
        quotes.add(Quote.fromJson(element));
      });

      return quotes;
    } catch (err) {
      print(err);
      return [];
    }
  }
}
