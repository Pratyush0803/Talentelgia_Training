import 'package:demo_user_app/pages/home/home_screen.dart';
import 'package:demo_user_app/pages/login/login.dart';
import 'package:demo_user_app/pages/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
      },
    ),
  );
}
