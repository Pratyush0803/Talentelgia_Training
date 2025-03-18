import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';

class SplashScreenApp extends StatelessWidget{
  const SplashScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> (MyHomePage())));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[300],
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 250),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Center(
                  child: Image.asset(
                      'assets'
                      '/images'
                          '/logo_splash_screen.png'
                  ),
                ),
              ),
            ),
            Text("Movie Flix",
            style:
              TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w500
              ),)
          ],
        ),

      ),
    );
  }

}