import 'package:flutter/material.dart';

import '../../../data/database_helper/sqflite_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // TextEditingController is used to control the text field.
  final TextEditingController _controller = TextEditingController();

  //helper is the instance of the SqfliteHelper class.
  SqfliteHelper helper = SqfliteHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.lightBlueAccent,
        elevation: 10,
      ),
      body: FutureBuilder(
        //helper.getTasks() returns a Future<List<Map<String, dynamic>>>.
        future: helper.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            //snapshot.data is the list of tasks that we get from the database.
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.blue[50],
                  elevation: 3,
                  child: ListTile(
                    leading: Checkbox(
                      checkColor: Colors.lightBlueAccent,
                      activeColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(width: 2.0, color: Colors.blueAccent),
                      ),
                      //We use 1 for true and 0 for false.
                      value: snapshot.data?[index]['status'] == 1 ? true : false,
                      onChanged: (value) async {
                        //updateTask method takes the id of the task and the status to be updated.
                        await helper.updateTask(
                          snapshot.data?[index]['id'],
                          value!,
                        );
                        //setState is used to update the UI.
                        setState(() {});
                      },
                    ),
                    title: Text(snapshot.data?[index]['title']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red,),
                      onPressed: () async {
                        //deleteTask method takes the id of the task to be deleted.
                        await helper.deleteTask(snapshot.data?[index]['id']);
                        //setState is used to update the UI.
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          //showDialog is used to show a dialog box, it takes a context and a builder.
          showDialog(
            context: context,
            builder: (context) {
              //AlertDialog is a dialog box with a title, content, and actions.
              return AlertDialog(
                backgroundColor: Colors.white,
                title: const Text('Add Task',style: TextStyle(color: Colors.black),),
                content: TextField(
                  //autofocus is used to focus the text field when the dialog box is shown.
                  autofocus: true,
                  //controller is used to control the text field.
                  controller: _controller,
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
                actions: [
                  TextButton(
                    onPressed: () {
                      //Navigator.pop is used to close the dialog box.
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel',style: TextStyle(color: Colors.red),),
                  ),
                  TextButton(
                    onPressed: () async {
                      //insertTask method takes the title of the task and the status.
                      await helper.insertTask(_controller.text, false);
                      //clear is used to clear the text field.
                      _controller.clear();
                      //here we are checking if the widget is mounted before popping the dialog box.
                      //because we are using context in async functions.
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                      //setState is used to update the UI.
                      setState(() {});
                    },
                    child: const Text('Add',style: TextStyle(color: Colors.black),),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
