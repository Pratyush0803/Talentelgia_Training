import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/main.dart';

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
              padding: const EdgeInsets.only(top: 280),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Image.asset(
                      'assets'
                      '/images'
                          '/popcorn.png'
                  ),
                ),
              ),
            ),
            Text("MovieFlix",
            style:
              TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500
              ),)
          ],
        ),

      ),
    );
  }

}