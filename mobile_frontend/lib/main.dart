import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sokcet IO',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Socket.IO Project'),
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
  int _counter = 0;
  IO.Socket socket=IO.io("http://localhost:3535/api");

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  requestFunction() async {
    var responseMessage;
    try {
      var getRequest = await http.get(Uri.parse('http://localhost:3535/api'));

      var responseBody = await json.decode(getRequest.body);

      if (getRequest.statusCode == 200) {
        responseMessage = responseBody["message"];
      } else {
        responseMessage =
            "OOps. Something went wrong while processing your request.";
      }
    } catch (e) {
      responseMessage = "Error connecting to server.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: ListTile(
              subtitle: Text('$responseMessage'),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: (() => Navigator.popAndPushNamed(context, '/')),
                  child: Text("OK")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Socket.IO',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: requestFunction,
        tooltip: 'Make request',
        child: const Icon(Icons.request_page),
      ),
    );
  }
}
