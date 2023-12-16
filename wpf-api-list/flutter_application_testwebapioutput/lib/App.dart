import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/repository/Pages/AuthrorizationScreen.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'dart:convert';
 import 'dart:io';
  
import 'package:get_it/get_it.dart';
void main() {

  Data data = Data();
  GetIt.I.registerSingleton(data);

  Api api = Api();
  GetIt.I.registerSingleton(api);

  Dio dio = Dio();
  GetIt.I.registerSingleton(dio);

   HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AuthrorizationScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  String text = "";
  late List<Item> items = [];

  @override
  void initState(){
    super.initState();
    req();
  }

  void req() async  {
  final dio = Dio();
  final response = await dio.get('https://localhost:7080/Shop/items');
  final jsonResponse = json.decode(response.data);
  for (var itemData in jsonResponse) {
      Item item = Item(
        itemID: itemData['ItemID'],
        item_categoryID: itemData['item_categoryID'],
        item_name: itemData['item_name'],
        item_price: itemData['item_price'].toDouble(),
      );
      items.add(item);
    }
  text = items.length.toString();
  setState(() {
  });
}
  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
    ),
    body: Center(
      child: items.isNotEmpty
          ? ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].item_name ?? ''),
                  leading: Text(items[index].item_categoryID ?? ''),
                  trailing: Text(items[index].item_price.toString()),
                );
              },
            )
          : const CircularProgressIndicator(strokeCap: StrokeCap.round,),
    ),
  );
}
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}