
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';

class Api {

  Future<List<Item>> getItems() async {
    final response = await getIt<Dio>().get('https://10.0.2.2:7080/getitems');
    List<Item> items = (jsonDecode(response.data) as List<dynamic>)
        .map((item) => Item.fromJson(item))
        .toList();
    return items;
  }

  Future<List<Category>> loadCategories() async {
    final response = await getIt<Dio>().get('https://10.0.2.2:7080/getcategories');
    List<Category> categories = (jsonDecode(response.data) as List<dynamic>).map((category) => Category.fromJson(category)).toList();
    return categories;
  }

  Future<bool> ping() async {
    Dio dio = Dio();
    try{
      final response = await dio.get('https://10.0.2.2:7080/ping');
      print(response.data);
      //idk how check suc status code
      return true;
    }catch (e) 
    {
      print(e);
      return false;
    }
  }
}
// https://10.0.2.2:7080/ping