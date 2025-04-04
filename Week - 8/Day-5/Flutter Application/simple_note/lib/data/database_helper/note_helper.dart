import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NoteHelper {
  Future<Database> openMyDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'noteDatabase.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            '''
          CREATE TABLE simpleNote(
            id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            title TEXT,
            description TEXT,
            status INTEGER
          )
          '''
        );
      },
    );
  }

  Future<void> insertNote(String title, String description, bool status) async {
    final db = await openMyDatabase();
    await db.insert(
      'simpleNote',
      {
        'title': title,
        'description': description,
        'status': status ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await openMyDatabase();
    await db.delete('simpleNote', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateNote(int id, bool status) async {
    final db = await openMyDatabase();
    await db.update(
      'simpleNote',
      {'status': status ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getNote() async {
    final db = await openMyDatabase();
    return await db.query('simpleNote');
  }
}
