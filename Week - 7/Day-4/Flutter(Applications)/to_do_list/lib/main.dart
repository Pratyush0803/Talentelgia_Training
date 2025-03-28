import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/screens/home_screen/home_screen.dart';
import 'package:to_do_list/screens/lets_start_screen/lets_start_screen.dart';
import 'package:to_do_list/todo_model_provider/todo_model_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final hasOpenedBefore = prefs.getBool('hasOpenedBefore') ?? false;

  runApp(
    ChangeNotifierProvider(
      create: (context) => ToDoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: hasOpenedBefore ? '/home' : '/',
        routes: {
          '/': (context) {
            prefs.setBool('hasOpenedBefore', true);
            return const LetsStartScreen();
          },
          '/home': (context) => const HomeScreen(),
        },
      ),
    ),
  );
}
