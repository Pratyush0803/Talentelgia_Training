import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text(
            "My First Container App",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          height: 100,
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.amberAccent[100],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 2)
          ),
          child: const Text(
            "Hello everyone iam inside a container",
            style: TextStyle(fontSize: 20,color: Colors.black),
          ),
        ),
      ),
    );
  }
}