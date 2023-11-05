import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/widgets/item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState(){
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    _tabController.addListener(_handeTabSelection);
    super.initState();
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
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text("Time to жрать...", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500,),),
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
                  Tab(text: "jopa",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "jopa",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                  Tab(text: "xui",),
                ]),
              const SizedBox(height: 10,),
              Center(
                child: const [
                  ItemsWidget(),
                  ItemsWidget(),
                  ItemsWidget(),
                  ItemsWidget(),][_tabController.index],
              )
            ],
          )
        )
        )
    );
  }
}