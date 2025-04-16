import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:products/screens/home_screen.dart';
import 'package:products/screens/login_screen.dart';
import 'package:products/screens/signup_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/loginScreen',
    routes: {
      '/loginScreen': (context) => const LoginScreen(),
      '/signupScreen': (context) => const SignupScreen(),
      '/home': (context) => const HomeScreen(),
    },
  ));
}
