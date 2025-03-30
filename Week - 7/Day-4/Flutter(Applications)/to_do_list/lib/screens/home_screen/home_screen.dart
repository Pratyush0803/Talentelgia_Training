import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/todo_action/to_do_action.dart';
import 'package:to_do_list/todo_model_provider/todo_model_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final _textFieldController = TextEditingController();
  String newTask = '';

  @override
  void initState() {
    super.initState();
    _textFieldController.addListener(() {
      newTask = _textFieldController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _textFieldController.dispose();
  }

  void _submit() {
    Provider.of<ToDoProvider>(context, listen: false).addTask(newTask);
    Navigator.pop(context);
    _textFieldController.clear();
  }

  String dropDownValue = 'Work';
  var items = ['Work', 'Personal', 'Shopping', 'Health'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 15, right: 15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: TextField(
                  decoration: InputDecoration(
                    fillColor: Colors.blue[50],
                    filled: true,
                    prefixIcon: Icon(Icons.search, size: 30),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black26),
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
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Freedom',
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton.outlined(
                          onPressed: () {},
                          icon: Icon(Icons.work_outline),
                          padding: EdgeInsets.all(25),
                          style: IconButton.styleFrom(
                            side: BorderSide(color: Colors.blue, width: 2),
                            foregroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Work",
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: 'Freedom',
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton.outlined(
                          onPressed: () {},
                          icon: Icon(Icons.person_2_outlined),
                          padding: EdgeInsets.all(25),
                          style: IconButton.styleFrom(
                            side: BorderSide(color: Colors.blue, width: 2),
                            foregroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Personal",
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Freedom',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton.outlined(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_cart_outlined),
                          padding: EdgeInsets.all(25),
                          style: IconButton.styleFrom(
                            side: BorderSide(color: Colors.blue, width: 2),
                            foregroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Shopping",
                              style: TextStyle(
                                color: Colors.orange,
                                fontFamily: 'Freedom',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IconButton.outlined(
                          onPressed: () {},
                          icon: Icon(Icons.health_and_safety_outlined),
                          padding: EdgeInsets.all(25),
                          style: IconButton.styleFrom(
                            side: BorderSide(color: Colors.blue, width: 2),
                            foregroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Health",
                              style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'Freedom',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Task List",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Freedom',
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                        fontFamily: 'Freedom',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: ToDoAction()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Expanded(
                child: Dialog(
                  backgroundColor: Colors.white,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      width: double.infinity,
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
                                  fontFamily: 'Freedom',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: TextField(
                              autofocus: true,
                              controller: _textFieldController,
                              onSubmitted: (_) => _submit(),
                              decoration: InputDecoration(
                                hintText: "Enter your task...",
                                fillColor: Colors.blue[50],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
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
                                    fontFamily: 'Freedom',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Dropdown Menu
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: DropdownButtonFormField<String>(
                              dropdownColor: Colors.blue[50],
                              value: dropDownValue,
                              icon: Icon(Icons.keyboard_arrow_down_sharp),
                              borderRadius: BorderRadius.circular(10),
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownValue = newValue!;
                                });
                              },
                              items:
                                  items.map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                              decoration: InputDecoration(
                                fillColor: Colors.blue[50],
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black26),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Add",
                                    style: TextStyle(fontFamily: 'Freedom'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   elevation: 10,
          //   context: context,
          //   builder: (BuildContext context) {
          //     return FractionallySizedBox(
          //       heightFactor: 0.5,
          //       widthFactor: 1,
          //       child: Container(
          //         margin: EdgeInsets.all(15),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Row(
          //               children: [
          //                 Text(
          //                   "Add task",
          //                   style: TextStyle(
          //                     fontSize: 20,
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.blue,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 5),
          //               child: TextField(
          //                 autofocus: true,
          //                 controller: _textFieldController,
          //                 onSubmitted: (_) => _submit(),
          //                 decoration: InputDecoration(
          //                   hintText: "Enter your task...",
          //                   fillColor: Colors.blue[50],
          //                   filled: true,
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.all(
          //                       Radius.circular(10),
          //                     ),
          //                     borderSide: BorderSide(color: Colors.black26),
          //                   ),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.all(
          //                       Radius.circular(10),
          //                     ),
          //                     borderSide: BorderSide(color: Colors.black26),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: EdgeInsets.only(top: 30),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   Text(
          //                     "Category",
          //                     style: TextStyle(
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.w500,
          //                       color: Colors.blue,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //             // Dropdown Menu
          //             Padding(
          //               padding: EdgeInsets.only(top: 10),
          //               child: DropdownButtonFormField<String>(
          //                 dropdownColor: Colors.blue[50],
          //                 value: dropDownValue,
          //                 icon: Icon(Icons.keyboard_arrow_down_sharp),
          //                 borderRadius: BorderRadius.circular(10),
          //                 elevation: 16,
          //                 style: TextStyle(color: Colors.black),
          //                 onChanged: (String? newValue) {
          //                   setState(() {
          //                     dropDownValue = newValue!;
          //                   });
          //                 },
          //                 items:
          //                     items.map<DropdownMenuItem<String>>((
          //                       String value,
          //                     ) {
          //                       return DropdownMenuItem<String>(
          //                         value: value,
          //                         child: Text(value),
          //                       );
          //                     }).toList(),
          //                 decoration: InputDecoration(
          //                   fillColor: Colors.blue[50],
          //                   filled: true,
          //                   enabledBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     borderSide: BorderSide(color: Colors.black26),
          //                   ),
          //                   focusedBorder: OutlineInputBorder(
          //                     borderRadius: BorderRadius.circular(10),
          //                     borderSide: BorderSide(color: Colors.black26),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 20),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.end,
          //                 children: [
          //                   FloatingActionButton(
          //                     onPressed: _submit,
          //                     backgroundColor: Colors.blue,
          //                     foregroundColor: Colors.white,
          //                     elevation: 10,
          //                     shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(30),
          //                     ),
          //                     child: Icon(Icons.check, size: 35),
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     );
          //   },
          // );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Icon(Icons.add, size: 35),
      ),
    );
  }
}
