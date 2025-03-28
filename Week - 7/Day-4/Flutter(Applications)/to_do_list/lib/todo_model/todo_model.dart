class ToDoModel{
  String todoTittle;
  bool completed;

  ToDoModel({required this.todoTittle, this.completed = false});

  void toggleCompleted(){
    completed = !completed;
  }
}