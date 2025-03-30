import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:to_do_list/todo_model/todo_model.dart';

class ToDoProvider with ChangeNotifier{
  final List<ToDoModel> _task = [];

  UnmodifiableListView<ToDoModel> get allTasks => UnmodifiableListView(_task);

  void addTask(String task){
    _task.add(ToDoModel(todoTittle: task,completed: false));
    notifyListeners();
  }
  void toggleTask(ToDoModel task){
    final taskIndex = _task.indexOf(task);
    _task[taskIndex].toggleCompleted();
    notifyListeners();
  }
  void deleteTask(ToDoModel task){
    _task.remove(task);
    notifyListeners();
  }
}