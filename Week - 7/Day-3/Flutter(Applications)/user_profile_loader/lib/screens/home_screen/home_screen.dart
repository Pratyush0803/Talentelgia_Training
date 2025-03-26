import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              elevation: 10,
              context: context,
              builder: (BuildContext context) {
                return FractionallySizedBox(
                  heightFactor: 0.7,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Card(
                                  color: Colors.deepOrange[100],
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    child: Text(
                                      "Please Pick",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.brown,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Quantity : ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.black12,
                                    ),
                                    onPressed: () {},
                                    icon: Icon(Icons.remove),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      right: 15,
                                    ),
                                    child: Text(
                                      "1",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  IconButton(
                                    style: IconButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      foregroundColor: Colors.black,
                                      backgroundColor: Colors.black12,
                                    ),
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Inglis 12000001 P-35",
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                        Text(
                                          "9mm 4.7' Barrel 15rd",
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                        Text(
                                          "Semi-Auto Pistol, Satin",
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                        Text(
                                          "Nickle w/ Black G10 Grip",
                                          style: TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30,top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      backgroundColor: Colors.deepOrange[100],
                                      foregroundColor: Colors.brown
                                    ),
                                      onPressed: () {},
                                      child: Text("Prev")),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,top: 20),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      backgroundColor: Colors.brown,
                                      foregroundColor: Colors.white
                                    ),
                                      onPressed: () {},
                                      child: Text("Next")),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Card(
                            elevation: 10,
                            child: Image.asset('assets/images/gun.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Text("Add"),
        ),
      ),
    );
  }
}
