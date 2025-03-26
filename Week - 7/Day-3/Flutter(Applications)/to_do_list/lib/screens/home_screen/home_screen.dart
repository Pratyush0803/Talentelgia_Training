import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String dropDownValue = 'Work'; // Default value

  var items = ['Work', 'Personal', 'Shopping', 'Health'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: Container(
          margin:  EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: TextField(
                  decoration: InputDecoration(
                    fillColor:  Color(0x262294F2),
                    filled: true,
                    prefixIcon:  Icon(Icons.search, size: 30),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:  BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:  BorderSide(color: Colors.black26),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                   Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:  EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton.outlined(
                      onPressed: () {},
                      icon:  Icon(Icons.work_outline),
                      padding:  EdgeInsets.all(25),
                      style: IconButton.styleFrom(
                        side:  BorderSide(color: Colors.blue, width: 2),
                        foregroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon:  Icon(Icons.person_2_outlined),
                      padding:  EdgeInsets.all(25),
                      style: IconButton.styleFrom(
                        side:  BorderSide(color: Colors.blue, width: 2),
                        foregroundColor:  Color(0xFFFF5722),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon:  Icon(Icons.shopping_cart_outlined),
                      padding:  EdgeInsets.all(25),
                      style: IconButton.styleFrom(
                        side:  BorderSide(color: Colors.blue, width: 2),
                        foregroundColor:  Color(0xFFFFC107),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {},
                      icon:  Icon(Icons.health_and_safety_outlined),
                      padding:  EdgeInsets.all(25),
                      style: IconButton.styleFrom(
                        side:  BorderSide(color: Colors.blue, width: 2),
                        foregroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      "Task List",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                     Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            elevation: 10,
            context: context,
            builder: (BuildContext context) {
              return FractionallySizedBox(
                heightFactor: 0.5,
                widthFactor: 1,
                child: Container(
                  margin:  EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           Text(
                            "Add task",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                       Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: TextField(
                          decoration: InputDecoration(
                            fillColor: Color(0x262294F2),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Dropdown Menu
                      Padding(
                        padding:  EdgeInsets.only(top: 10),
                        child: DropdownButtonFormField<String>(
                          dropdownColor: Colors.blue[200],
                          value: dropDownValue,
                          icon:  Icon(Icons.keyboard_arrow_down_sharp),
                          borderRadius: BorderRadius.circular(10),
                          elevation: 16,
                          style:  TextStyle(color: Colors.black),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropDownValue = newValue!;
                            });
                          },
                          items: items
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                              fillColor:  Color(0x262294F2),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                 BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                 BorderSide(color: Colors.black26),
                              )
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(onPressed: (){},
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              elevation: 10,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              child:  Icon(Icons.check, size: 35),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child:  Icon(Icons.add, size: 35),
      ),
    );
  }
}