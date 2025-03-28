import 'package:flutter/material.dart';

class LetsStartScreen extends StatefulWidget {
  const LetsStartScreen({super.key});

  @override
  State<StatefulWidget> createState() => LetsStartScreenState();
}

class LetsStartScreenState extends State<LetsStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 150),
              child: SizedBox(
                child: Image.asset('assets/images/on_boarding.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(
                "Simplify, Organize, and",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Conquer ",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Your Day",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2196F3),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Take control of your task and",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Text("achieve your goal.", style: TextStyle(fontSize: 18)),
            SizedBox(height: 70),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Color(0xFF2196F3),
                  foregroundColor: Colors.white
                ),
                child: Text("Lets Start",
                  style: TextStyle(
                      fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
