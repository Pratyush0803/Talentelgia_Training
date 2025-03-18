import 'package:flutter/material.dart';

class OnBoard extends StatelessWidget{
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoardScreen(),
    );
  }
}

class OnBoardScreen extends StatefulWidget{
  const OnBoardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 100),
              child: Text("Tell Us Your Interests!",
                style:
                TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text("Select your favorite genres",
                style:
                TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text("to get personalised recommendation",
                style:
                TextStyle(
                    fontSize: 18
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40, left: 30),
                  child: Text("You can choose up to 4 genres.",
                    style:
                    TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: Card(
                      margin: EdgeInsets.all(10),
                      color: Colors.white70,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text("Comedy"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}