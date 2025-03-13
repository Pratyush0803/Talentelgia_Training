import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0; // State to track bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
        title: const Text(
          "This is a title bar",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text(
          "Welcome to my app",
          style: TextStyle(
            color: Colors.black,
            fontSize: 40,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        elevation: 10,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          // Add action for FAB
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue[300]),
              child: const Text(
                "Random Application",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text("Users"),
              leading: const Icon(Icons.people_alt_rounded),
              onTap: () {
                // Handle Users tap
              },
            ),
            ListTile(
              title: const Text("Settings"),
              leading: const Icon(Icons.settings),
              onTap: () {
                // Handle Settings tap
              },
            ),
            ListTile(
              title: const Text("Menu"),
              leading: const Icon(Icons.menu_book_rounded),
              onTap: () {
                // Handle Menu tap
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.lightBlue[300],
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.account_circle),
          ),
        ],
        onTap: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
