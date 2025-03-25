import 'package:flutter/material.dart';
import 'package:named_routing/models/counter_model/counter_model.dart';
import 'package:named_routing/screens/home_screen/home_screen.dart';
import 'package:named_routing/screens/start_screen/start_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_)=> CounterModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/home': (context) => const HomeScreen(),
      },
    ),
  ));
}
