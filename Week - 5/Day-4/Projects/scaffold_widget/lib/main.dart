import 'package:flutter/foundation.dart';
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
        title: Text("This is a app bar"),
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Text(
          "Hello Everyone",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Colors.lightBlue[200],
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {
          if (kDebugMode) {
            print("Hi iam a floating button");
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      drawer: Drawer(
        elevation: 10,
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("Pratyush Kumar Jena"),
              accountEmail: Text("talent.pratyush@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text("P", style: TextStyle(color: Colors.white)),
              ),
            ),
            ListTile(title: Text("All inboxes"), leading: Icon(Icons.all_inbox_outlined)),
            Divider(
              height: 1,
            ),
            ListTile(title: Text("Primary"), leading: Icon(Icons.inbox_outlined)),
            ListTile(
              title: Text("Social"), leading: Icon(Icons.people_outline)),

            ListTile(
              title: Text("Promotion"), leading: Icon(Icons.local_offer_outlined),
            ),
            ListTile(
              title: Text("Updates"), leading: Icon(Icons.update),
            ),
          ],
        ),
      ),
    );
  }
}
