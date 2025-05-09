import '../../model/todo_model.dart';
import '../db_helper/db_helper.dart';

class TodoRepository {
  final dbHelper = DBHelper.dbHero;

  Future<int> insert(Todo todo) async {
    return await dbHelper.insertDb(todo.toMap());
  }

  Future<List<Todo>> getAllTodos() async {
    final List<Map<String, dynamic>> maps = await dbHelper.readDb();
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'] as int,
        name: maps[i]['name'] ?? '',
        description: maps[i]['description'] ?? '',
      );
    });
  }

  Future<int> update(Todo todo) async {
    return await dbHelper.updateDb(todo.toMap());
  }

  Future<int> delete(int id) async {
    return await dbHelper.deleteDb(id);
  }
}
