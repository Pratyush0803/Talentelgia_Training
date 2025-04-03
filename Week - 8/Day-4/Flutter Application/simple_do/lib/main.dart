import 'package:flutter/material.dart';
import 'package:simple_do/presentation/screens/home/homescreen.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomeScreen(),
    },
  ));
}