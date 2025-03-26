import 'package:flutter/material.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';
import 'package:to_do_list/screens/lets_start_screen/lets_start_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
initialRoute: '/',
    routes: {
      '/': (context)=>const LetsStartScreen(),
      '/home': (context)=>const HomeScreen(),
    },
  ));
}
