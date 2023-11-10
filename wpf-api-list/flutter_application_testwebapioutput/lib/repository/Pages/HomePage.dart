import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/Data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'package:flutter_application_testwebapioutput/repository/widgets/itemWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  List<Item> _items = getIt<Data>().itemList;
  List<Category> _categories = getIt<Data>().itemCategory;
  String server = "";

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: _categories.length , vsync: this, initialIndex: 0);
    _tabController.addListener(_handeTabSelection);
    
  }

  _handeTabSelection(){
    if(_tabController.indexIsChanging){
      setState(() {
        
      });
    }
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){

                      },
                      child: const Icon(Icons.sort,size: 35,),
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: const Icon(Icons.notifications_rounded,size: 35,),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 0,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text("Time to хавать...$server", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),),
                ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                height: 60,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Find you bludo epta",
                      hintStyle: TextStyle(
                        color: Colors.yellow.withOpacity(0.7)
                      ),
                      prefixIcon: const Icon(Icons.search, size: 30, color: Colors.yellow,)
                    ),
                )
              ),
              const SizedBox(height: 15,),
              TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: const [
                  Tab(text: "eda",),
                ]),
              const SizedBox(height: 10,),
              Center(
  child: _items.isEmpty
      ? const CircularProgressIndicator()
      : Container(
          height: 800, // Set a fixed height or adjust to your requirements
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2
            ),
            itemCount: _items.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemWidget(item:_items[index]);
            },
          ),
        ),
)


              // Center(
              //   child: const [
              //     ItemsWidget(),
              //     ItemsWidget(),
              //     ItemsWidget(),
              //     ItemsWidget(),][_tabController.index],
              // )
            ],
          )
        )
        )
    );
  }
}