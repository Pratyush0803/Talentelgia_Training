import 'package:flutter/material.dart';
import 'package:movie_app/Screens/on_board/on_board_screen.dart';
import 'package:movie_app/Screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
        home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.limeAccent[100],
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Text("Welcome to MovieFlix",
                style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Discover and enjoy the best podcasts",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("all genres - anytime, anywhere",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Image.asset('assets/images/logo_entry.png'),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 150),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepOrange[500],
                  // maximumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> OnBoard()));
                  },
                  child: Text("Next",
                    style: TextStyle(),
                  ),
              ),
            ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  // maximumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                  onPressed: (){

                  },
                  child: Text("Skip",
                    style: TextStyle(),
                  ),
              ),
            ),
            ),

          ],
        ),
      ),
    );
  }
}
