import 'package:flutter/material.dart';
import 'package:flutter_application_tau/data/OnBoardContent.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {

  int currentIndex = 0;

  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index){
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: contents.length,
              itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Icon(contents[index].icon, size: 300,),
                        Text(contents[index].title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 36),),
                      ],
                    ),
                  );
                },
              ),
          ),
          const SizedBox(height: 20,),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(contents.length, (index) => buildDot(context,index)
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.all(40),
            child: FilledButton(
              onPressed: (){
                if(currentIndex != contents.length-1){
                  _controller.nextPage(
                    duration: const Duration(seconds: 1), 
                    curve: Curves.fastEaseInToSlowEaseOut
                  );
                }
              },
              child: const Text("Next"),
              )
          )
        ],
      ),
    );
  }

  Container buildDot(BuildContext context, int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor
      ),
    );
  }
}