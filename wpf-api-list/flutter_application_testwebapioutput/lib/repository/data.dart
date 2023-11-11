import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';

class Data {
  List<Item> itemList = [];
  List<Category> itemCategory = [];

  // Приватное статическое свойство для хранения единственного экземпляра класса
  static final Data _singleton = Data._internal();

  // Приватный конструктор
  Data._internal();

  // Фабричный метод для получения экземпляра класса
  factory Data() {
    return _singleton;
  }
}
