import 'package:flutter/material.dart';
import 'package:flutter_application_testwebapioutput/repository/data.dart';
import 'package:flutter_application_testwebapioutput/repository/models/Item.dart';
import 'package:get_it/get_it.dart';

class HomePageCartPage extends StatefulWidget {
  final PageController pageController;
  const HomePageCartPage({super.key, required this.pageController});

  @override
  State<HomePageCartPage> createState() => _HomePageCartPageState();
}

class _HomePageCartPageState extends State<HomePageCartPage> {
  late final List<String> itemsCart;
  late final Data dataInstance;

  @override
  void initState() {
    dataInstance = GetIt.I.get<Data>();
    itemsCart = dataInstance.user.cart_items != null
        ? dataInstance.user.cart_items!
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return itemsCart.isEmpty
        ? emptyCartScreen(widget.pageController)
        : CartScreen(dataInstance);
  }
}

Widget CartScreen(Data data) {
  double cartPrice = 0;
  int loopindex = 0;

  data.user.cart_items?.forEach((element) {
    var matchedItems = data.itemList
        .where((item) => item.itemID == data.user.cart_items![loopindex])
        .toList();
    if (matchedItems.isNotEmpty) {
      var itemPrice = matchedItems[0].item_price;
      if (itemPrice != null) {
        cartPrice += itemPrice;
      }
    }
    loopindex++;
  });

  return Scaffold(
    body: SafeArea(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
            Color.fromARGB(255, 213, 203, 216),
            Color.fromARGB(255, 167, 98, 211)
          ])),
      child: Stack(
        children: [
          NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                        floating: true,
                        snap: true,
                        elevation: 10,
                        backgroundColor: Color.fromARGB(255, 120, 68, 152),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Корзина (" +
                                    data.user.cart_items!.length.toString() +
                                    ")",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("К оплате: $cartPrice₽",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14)),
                          ],
                        )),
                  ],
              body: ListView.builder(
                itemCount: data.user.cart_items?.length,
                itemBuilder: (context, index) {
                  final item = data.itemList
                      .where((element) =>
                          data.user.cart_items?[index] == element.itemID)
                      .toList()[0];
                  return Container(
                    height: 220,
                    padding: const EdgeInsets.all(20),
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item.item_image![0]),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item.item_price.toString() + "₽",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 5,
                                              color: Colors.black)
                                        ],
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ("${item.item_price! * 2}").toString() +
                                        "₽",
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                            blurRadius: 5, color: Colors.black)
                                      ],
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 16,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        height: 40,
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(Icons.menu),
                                          color: Colors.white,
                                          onPressed: () {},
                                        )),
                                  )
                                ],
                              ),
                              Text(
                                item.item_name!,
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(blurRadius: 5, color: Colors.black)
                                  ],
                                ),
                              ),
                              const Text(
                                "Цвет: настроения",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(blurRadius: 5, color: Colors.black)
                                  ],
                                ),
                              ),
                              const Text(
                                "Склад: хз какой-то",
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(blurRadius: 5, color: Colors.black)
                                  ],
                                ),
                              ),
                              Text(
                                "100₽ за возврат на склад при отказе",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withAlpha(200),
                                  shadows: [
                                    Shadow(blurRadius: 5, color: Colors.black)
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              Icon(Icons.add),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal:8.0),
                                                child: Text(
                                                  "5",
                                                  style: TextStyle(color: Colors.black),
                                                ),
                                              ),
                                              Icon(Icons.remove)
                                            ],
                                          ),
                                        ),
                                      )),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          "Купить",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )),
          Align(
            alignment: const Alignment(0, 0.9),
            child: Container(
                height: 60,
                width: 300,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 149, 1, 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "К оформлению",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    Text(
                      "4шт., 25₽",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16),
                    ),
                  ],
                )),
          )
        ],
      ),
    )),
  );
}

Widget emptyCartScreen(PageController page) {
  return Scaffold(
    body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
              Color.fromARGB(255, 213, 203, 216),
              Color.fromARGB(255, 167, 98, 211)
            ])),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Корзина пуста",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const Text("Закажите товары из каталога"),
            ElevatedButton(
                onPressed: () {
                  page.animateToPage(0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: const Text("Перейти в каталог"))
          ],
        )),
      ),
    ),
  );
}
