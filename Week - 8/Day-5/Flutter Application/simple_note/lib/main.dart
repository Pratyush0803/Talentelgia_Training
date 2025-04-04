import 'package:flutter/material.dart';
import 'package:simple_note/presentation/screens/home/home_page.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const HomePage(),
    },
  ));
}