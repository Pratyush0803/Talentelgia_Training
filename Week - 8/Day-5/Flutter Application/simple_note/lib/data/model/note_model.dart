import 'package:simple_note/data/database_helper/note_helper.dart';

class Note {
  final int? id;
  bool? status;
  final String? title;
  final String? description;

  Note({this.id, this.status, this.title, this.description});

  NoteHelper noteHelper = NoteHelper();
  List<Note> notes = [];

  createNote(Note note) async {
    await noteHelper.insertNote(note.title!, note.description!, note.status!);
    notes.clear();
    await getNote();
  }

  deleteTask(Note note) async {
    final index = notes.indexOf(note);
    notes.removeAt(index);
    await noteHelper.deleteNote(note.id!);
  }

  updateTask(Note note) async {
    final index = notes.indexOf(note);
    notes[index].status = !notes[index].status!;
    await noteHelper.updateNote(note.id!, note.status!);
  }

  getNote() async {
    for (var item in await noteHelper.getNote()) {
      notes.add(fromMap(item));
    }
  }

  Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      status: map['status'] == 1 ? true : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status! ? 1 : 0
    };
  }
}
