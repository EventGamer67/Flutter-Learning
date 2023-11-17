import 'dart:ffi';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/api/api.dart';
import 'package:flutter_application_testwebapioutput/main.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Category.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'package:flutter_application_testwebapioutput/repository/widgets/TextField.dart';
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
  late TextEditingController _controller;
  late List<Item> _filteredItems;
  late String _filteredCategory;
  late String _filteredText;
  String server = "";

  @override
  void initState() {
    super.initState();
    
    // Retrieve Data instance from GetIt
    final dataInstance = GetIt.instance.get<Data>();
    
    // Access data properties or perform operations
    _items = dataInstance.itemList;
    _categories = dataInstance.itemCategory;
    _categories.insert(0, Category(category_name: "All", categoryID: ""));
    _filteredCategory = "";
    // Other initialization logic
    _tabController = TabController(length: _categories.length, vsync: this);
    _controller = TextEditingController();
    _filteredText = "";
    _filteredItems = _items;
  }

  _handeTabSelection(index){
    _filteredCategory = _categories[index].categoryID!;
    showFiltered();
  }

  void showFiltered(){
    _filteredItems = _items;
    if(_filteredText != ""){
      _filteredItems = _filteredItems.where((element) => element.item_name!.toLowerCase().contains(_filteredText.toLowerCase())).toList();
    }
    if(_filteredCategory != ""){
      _filteredItems = _filteredItems.where((element) => element.item_categoryID == _filteredCategory).toList();
    }
    setState(() {
      
    });
  }

  void searchTextChanged(text){
    _filteredText = _controller.text;
    showFiltered();
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: SliverAppBar(
      //   toolbarHeight: 10,
      // ),
      // appBar: AppBar(
        
      // ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.home_outlined), label: "asd"),
          BottomNavigationBarItem(icon:Icon(Icons.shopping_cart_outlined), label: "asd"),
          //BottomNavigationBarItem(icon:Icon(Icons.person_3_outlined), label: "asd"),
        ],
      ),
      endDrawer: Drawer(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Filters",style: TextStyle(fontSize: 36),),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      border: Border.all(color: Colors.purple)
                    ),
                    child: TextField(
                      controller: _controller,
                      onChanged: (text) { searchTextChanged(text); },
                      decoration: const InputDecoration(
                        hintText: "Ищем...",
                        border: InputBorder.none,
                        icon: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Icon(Icons.search_outlined),
                        ),
                      ),
                    ),
                  ),
                  const DropdownMenu(dropdownMenuEntries: [ DropdownMenuEntry(value: "value", label: "label") ])
                  ]
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [ 
            SliverAppBar(
              floating: true, 
              title: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(40)),
                  border: Border.all(color: Colors.purple,width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextField(
                    controller: _controller,
                    onChanged: (text) { searchTextChanged(text); },
                    decoration: InputDecoration(
                      hintText: "Ищем...",
                      border: InputBorder.none,
                      icon: const Icon(Icons.search_outlined),
                    ),
                  ),
                ),
              ), 
              centerTitle: true,
              snap: true,
              bottom: TabBar(
                onTap: (index) {_handeTabSelection(index);},
                controller: _tabController,
                isScrollable: true,
                tabs: [
                  for (int i = 0; i < _categories.length; i++)
                    _categories[i].category_name != null
                        ? Tab(text: _categories[i].category_name)
                        : const Tab(text: 'Default Text'), // Provide a default text if category_name is null
                ],
              ),
              ) ],
          body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2
                ),
                itemCount: _filteredItems.length,
                itemBuilder: (BuildContext context, int index) {
                return ItemWidget(item:_filteredItems[index]);
              },
              ),
          // // body: ListView(
          // //   children: [
          // //     // Padding(
          // //     //   padding: const EdgeInsets.symmetric(horizontal: 20),
          // //     //   child:Row(
          // //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // //     //     children: [
          // //     //       InkWell(
          // //     //         onTap: (){
                  
          // //     //         },
          // //     //         child: const Icon(Icons.sort,size: 35,),
          // //     //       ),
          // //     //       InkWell(
          // //     //         onTap: (){
                  
          // //     //         },
          // //     //         child: const Icon(Icons.notifications_rounded,size: 35,),
          // //     //       )
          // //     //     ],
          // //     //   ),
          // //     // ),
          // //     // const SizedBox(height: 0,),
          // //     // Padding(
          // //     //   padding: const EdgeInsets.symmetric(horizontal: 15),
          // //     //   child: Text("Time to хавать...$server", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500,),),
          // //     //   ),
          // //     // Container(
          // //     //   margin: const EdgeInsets.symmetric(horizontal: 15),
          // //     //   width: MediaQuery.of(context).size.width,
          // //     //   height: 60,
          // //     //   alignment: Alignment.center,
          // //     //   decoration: const BoxDecoration(
          // //     //     color: Colors.purple,
          // //     //     borderRadius: BorderRadius.all(Radius.circular(20))
          // //     //   ),
          // //     //   child: TextField(
          // //     //       decoration: InputDecoration(
          // //     //         border: InputBorder.none,
          // //     //         hintText: "Find you bludo epta",
          // //     //         hintStyle: TextStyle(
          // //     //           color: Colors.yellow.withOpacity(0.7)
          // //     //         ),
          // //     //         prefixIcon: const Icon(Icons.search, size: 30, color: Colors.yellow,)
          // //     //       ),
          // //     //   )
          // //     // ),
          // //     // const SizedBox(height: 15,),
          // //     // TabBar(
          // //     //   controller: _tabController,
          // //     //   isScrollable: true,
          // //     //   tabs: [
          // //     //     for (int i = 0; i < _categories.length; i++)
          // //     //       _categories[i].category_name != null
          // //     //           ? Tab(text: _categories[i].category_name)
          // //     //           : const Tab(text: 'Default Text'), // Provide a default text if category_name is null
          // //     //   ],
          // //     // ),
          // //     //const SizedBox(height: 10,),
          // //     // GridView.builder(
          // //     //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // //     //     crossAxisCount: 2,
          // //     //     mainAxisSpacing: 2,
          // //     //     crossAxisSpacing: 2
          // //     //   ),
          // //     //   itemCount: 10,
          // //     //   itemBuilder: (BuildContext context, int index) {
          // //     //   return ItemWidget(item: Item(itemID: "",item_categoryID:"", item_name: "", item_price: 1, item_image: List<String>.of(["asd","asd"])  ));
          // //     // },
          // //     // ),
          // //     // GridView.builder(
          // //     //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // //     //     crossAxisCount: 2,
          // //     //     mainAxisSpacing: 2,
          // //     //     crossAxisSpacing: 2
          // //     //   ),
          // //     //   itemCount: _items.length,
          // //     //   itemBuilder: (BuildContext context, int index) {
          // //     //   return ItemWidget(item:_items[index]);
          // //     // },
          // //     // ),
          // //     Text("asd")
          // // ],
          // ),
        )
        )
    );
  }
}