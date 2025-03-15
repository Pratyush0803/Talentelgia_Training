import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text("Container"),
      ),
      // body: Container(
      //   color: Colors.lightBlue[100],
      //   height: 500,
      //   width: double.infinity,
      //   margin: EdgeInsets.all(10),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: <Widget>[
      //       Text(" Friday "),
      //       Text(" Saturday "),
      //       Text(" Sunday "),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: <Widget>[
      //           Text(" Monday "),
      //           Text(" Tuesday "),
      //           Text(" Wednesday "),
      //         ],),
      //     ],
      //   ),
      // ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.redAccent,
              child: Text("Apple"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.yellowAccent,
              child: Text("Bat"),
            ),
          ),
          // Expanded(
          //   flex: 3,
          //   child: Container(
          //     padding: EdgeInsets.all(10),
          //     color: Colors.tealAccent,
          //     child: Text("Caram"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
