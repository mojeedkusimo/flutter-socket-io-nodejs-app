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
  var responseMessage;
  int _counter = 0;

  webSocketFucntion() {
    var socket = IO.io("http://localhost:3535", {
      "transports": ['websocket'],
      "autoConnect": true
    });
    socket.connect();
    socket.onConnect((data) => {
          if (socket.connected)
            {
              responseMessage =
                  "Connected to server through web socket Successfully."
            }
          else
            {responseMessage = "Error connecting through web socket."},

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
        })

        });
  }

  httpFunction() async {
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
      floatingActionButton: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.0,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            mainAxisExtent: 100.0),
        children: [
          FloatingActionButton(
            onPressed: httpFunction,
            tooltip: 'Make HTTP request',
            child: const Icon(Icons.http),
          ),
          FloatingActionButton(
            onPressed: webSocketFucntion,
            tooltip: 'Make WebSocket request',
            child: const Icon(Icons.connected_tv),
          )
        ],
      ),
    );
  }
}
