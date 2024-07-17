import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:router_unlocker/bluteForce.dart';

void main() {
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final BlutoForceController _blutoForceController = BlutoForceController();

  final TextEditingController _controller = TextEditingController();

  Res? _response;
  String _name = "name";
  String _password = "password";

  String _nameSuc = "name - until Sucess";
  String _passwordSuc = "password - until Sucess";

  int _sec = 0;

  void buttonTapped(){
    sendRequest();
    secInc();
  }

  void sendRequest() async {
    int len = int.parse(_controller.text);
    if(len == 0) return;
    
    _blutoForceController.run(len).listen((Res res) {
      setState(() {
        _response = res;
        _name = res.name;
        _password = res.password;

        if(_response?.statusCode == 200){
          _nameSuc = res.name;
          _passwordSuc = res.password;
        }
      });
    });
  }

  void secInc(){
    Timer.periodic(
      const Duration(seconds: 1), 
      (time) {
        setState(() {
          _sec++;
        });
      }
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("time"),
            Text("${_sec.toString()} s"),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_name),
                  Text(_password),
                ],
              ),
            ),
            TextButton(
              onPressed: buttonTapped, 
              child: const Text("send request")
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 128),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text("STATUS CODE"),
                  Text(_response?.statusCode.toString() ?? ""),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text("応答ヘッダ"),
                  Text(_response?.body ?? "")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(_nameSuc),
                  Text(_passwordSuc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
