import 'package:flutter/material.dart';
import '../../database/todo_repository/todo_repository.dart';
import '../../model/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TodoRepository _todoRepository = TodoRepository();

  List<Todo> _todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _loadTodos() async {
    final todos = await _todoRepository.getAllTodos();
    setState(() {
      _todos = todos;
    });
  }

  void _addTodo() async {
    final name = _nameController.text;
    final description = _descriptionController.text;
    if (name.isNotEmpty && description.isNotEmpty) {
      final todo = Todo(name: name, description: description);
      await _todoRepository.insert(todo);
      _nameController.clear();
      _descriptionController.clear();
      _loadTodos();
    }
  }

  void _updateTodo(Todo todo) async {
    final updatedTodo = Todo(
      id: todo.id,
      name: _nameController.text,
      description: _descriptionController.text,
    );
    await _todoRepository.update(updatedTodo);
    _nameController.clear();
    _descriptionController.clear();
    _loadTodos();
  }

  void _deleteTodo(int id) async {
    await _todoRepository.delete(id);
    _loadTodos();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Todo Name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _addTodo();
                  },
                  child: Text('Add Todo'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return ListTile(
                  title: Text(todo.name),
                  subtitle: Text(todo.description),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _nameController.text = todo.name;
                      _descriptionController.text = todo.description;
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text('Edit Todo'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: _nameController,
                                decoration:
                                InputDecoration(labelText: 'Todo Name'),
                              ),
                              TextField(
                                controller: _descriptionController,
                                decoration:
                                InputDecoration(labelText: 'Description'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _updateTodo(todo);
                                Navigator.of(context).pop();
                              },
                              child: Text('Update'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Delete Todo'),
                        content: Text(
                            'Are you sure you want to delete this todo?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              _deleteTodo(todo.id!);
                              Navigator.of(context).pop();
                            },
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
