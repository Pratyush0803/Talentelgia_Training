import 'package:flutter/material.dart';
import 'package:user_profile_loader/screens/get_started_screen/get_started_screen.dart';
import 'package:user_profile_loader/screens/home_screen/home_screen.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes:{
          '/': (context) =>const GetStartedScreen(),
          '/home': (context) =>const HomeScreen(),
        },

      )
  );
}
