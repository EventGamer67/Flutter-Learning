
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_application_testwebapioutput/api/requestModels/UserDto.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'package:flutter_application_testwebapioutput/repository/models/User.dart';
import 'package:get_it/get_it.dart';

class Api {

  Future<bool> Login({required password, required login}) async {
    try {
      final userDto = UserDto(user_name: login, password: password);
      final response = await GetIt.I.get<Dio>().post('https://10.0.2.2:7080/login',data: userDto.toJson(),);
      if (response.statusCode == 200) { // Check for a successful response
        print(response.data["item2"]);
        //final userData = response.data[0] as Map<String, dynamic>; // Assuming data is already parsed
        final userData = response.data["item1"];
        final token = response.data["item2"];
        final user = User.fromJson(userData);

        final dataInstance = GetIt.I.get<Data>();
        dataInstance.user = user;
        dataInstance.token = token;
        return true;
      } 
      else 
      {
        // Handle non-200 status code, e.g., show an error message
        return false;
      }
    } 
    catch (e) 
    {
      print(e); // Log DioException for further investigation
      return false;
    }
  }

  Future<List<Item>> getItems() async {
    final response = await GetIt.I.get<Dio>().get('https://10.0.2.2:7080/getitems');
    List<Item> items = (jsonDecode(response.data) as List<dynamic>)
        .map((item) => Item.fromJson(item))
        .toList();
    return items;
  }

  Future<List<Category>> loadCategories() async {
    final response = await GetIt.I.get<Dio>().get('https://10.0.2.2:7080/getcategories');
    List<Category> categories = (jsonDecode(response.data) as List<dynamic>).map((category) => Category.fromJson(category)).toList();
    return categories;
  }

  Future<bool> ping() async {
    try{
      final response = await GetIt.I.get<Dio>().get('https://10.0.2.2:7080/ping');
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