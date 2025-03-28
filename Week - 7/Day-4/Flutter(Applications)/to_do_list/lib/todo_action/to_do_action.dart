import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/todo_model_provider/todo_model_provider.dart';

class ToDoAction extends StatelessWidget {
  const ToDoAction({super.key});

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<ToDoProvider>(context);
    return ListView.builder(
      itemCount: task.allTasks.length,
      itemBuilder:
          ((context, index) => Card(
            color: Colors.blue[50],
            child: ListTile(
              leading: Checkbox(
                checkColor: Colors.blue,
                activeColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: WidgetStateBorderSide.resolveWith(
                      (states) => BorderSide(width: 1.0, color: Colors.black),
                ),
                value: task.allTasks[index].completed,
                onChanged: ((_) => task.toggleTask(task.allTasks[index])),
              ),
              title: Text(task.allTasks[index].todoTittle),
              trailing: IconButton(
                color: Colors.blue,
                onPressed: () {
                  task.deleteTask(task.allTasks[index]);
                },
                icon: Icon(Icons.delete_outline),
              ),
            ),
          )),
    );
  }
}
