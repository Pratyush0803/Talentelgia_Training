import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List movies = [];

  Future<void> fetchUser() async {
    final url = 'http://192.168.0.32:3001/movies';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        movies = jsonDecode(response.body);
      });
    } else {
      throw Exception("Failed to load user data");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyanAccent,
            elevation: 10,
            title: Text(
                "My First API Call")
        ),
      body: Center(
        child: ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index){
          return Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            child: Card(
              elevation: 10 ,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movies[index]['title']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movies[index]['director']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movies[index]['year'].toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movies[index]['actors'].toString()),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(movies[index]['poster']),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
