import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'package:flutter_application_testwebapioutput/repository/widgets/itemWidget.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  late List<Item> _items;
  late List<Category> _categories;
  String server = "";

  @override
  void initState() {
    super.initState();
    
    // Retrieve Data instance from GetIt
    final dataInstance = GetIt.instance.get<Data>();
    
    // Access data properties or perform operations
    _items = dataInstance.itemList;
    _categories = dataInstance.itemCategory;

    // Other initialization logic
    _tabController = TabController(length: _categories.length, vsync: this);
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
        child: Stack(
          children: [
            Padding(
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
                    tabs: [
                      for (int i = 0; i < _categories.length; i++)
                        _categories[i].category_name != null
                            ? Tab(text: _categories[i].category_name)
                            : Tab(text: 'Default Text'), // Provide a default text if category_name is null
                    ],
                  ),
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
          ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment(0.0,1.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                child: BottomNavigationBar(
                  showUnselectedLabels: false,
                  showSelectedLabels: false,
                  items: [
                      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "HOME"),
                      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ""),
                      BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined), label: ""),
                  ],
                ),
              ),
            ),
          )
          ]
        )
        )
    );
  }
}