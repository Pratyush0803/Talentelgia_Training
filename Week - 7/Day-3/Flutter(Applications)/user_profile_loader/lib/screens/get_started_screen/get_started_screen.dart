import 'package:flutter/material.dart';

class GetStartedScreen extends StatefulWidget{
  const GetStartedScreen({super.key});

  @override
  State<StatefulWidget> createState() => GetStartedScreenState();

}

class GetStartedScreenState extends State<GetStartedScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB27D48),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Welcome to User List",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                color: Colors.white
              )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/home');
                    },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF85572A),
                    foregroundColor: Colors.white,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                    child: Text("Let's get stated",style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}