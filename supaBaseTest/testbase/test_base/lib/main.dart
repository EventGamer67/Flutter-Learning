import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Instantiating the class with the Ip and the PortNumber
  TcpSocketConnection socketConnection=TcpSocketConnection("172.17.131.24", 8888);

  String message="no recieve";

  @override
  void initState() {
    super.initState();
    startConnection();
  }

  //receiving and sending back a custom message
  void messageReceived(String msg)
  {
    
    setState(() {
      message=msg;
    });
    socketConnection.sendMessage("MessageIsReceived :D ");
  }

  //starting the connection and listening to the socket asynchronously
  void startConnection() async{
    socketConnection.enableConsolePrint(true);    //use this to see in the console what's happening
    if(await socketConnection.canConnect(5000, attempts: 3))
    {   //check if it's possible to connect to the endpoint
      await socketConnection.connect(5000, messageReceived, attempts: 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          'You have received '+ message,
        ),
      ),
    );
  }
}