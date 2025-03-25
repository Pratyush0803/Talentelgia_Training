import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget{
  const StartScreen({super.key});

  @override
  State<StatefulWidget> createState() => StartScreenState();

}

class StartScreenState extends State<StartScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset('assets/images/bg.png', fit: BoxFit.cover),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Welcome to My app",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text("Let's Explore"),
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}