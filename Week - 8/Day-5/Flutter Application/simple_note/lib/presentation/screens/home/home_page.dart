import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_note/data/database_helper/note_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  NoteHelper noteHelper = NoteHelper();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
          "SimpleNote",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
      ),
      body: FutureBuilder(
        future: noteHelper.getNote(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            snapshot.data?[index]['title'],
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 250,
                            child: SingleChildScrollView(
                              child: Text(
                                snapshot.data?[index]['description'],
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'Close',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.lightBlueAccent,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Card(
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
                            (states) =>
                                BorderSide(width: 2.0, color: Colors.blueAccent),
                          ),
                          value:
                              snapshot.data?[index]['status'] == 1 ? true : false,
                          onChanged: (value) async {
                            await noteHelper.updateNote(
                              snapshot.data?[index]['id'],
                              value!,
                            );
                            setState(() {});
                          },
                        ),
                        title: Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          snapshot.data?[index]['title'],
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // subtitle: Text(
                        //   snapshot.data?[index]['description'],
                        //   style: GoogleFonts.montserrat(
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                        trailing: IconButton(
                          onPressed: () async {
                            await noteHelper.deleteNote(
                              snapshot.data?[index]['id'],
                            );
                            setState(() {});
                          },
                          icon: Icon(Icons.delete_outline),
                          color: Colors.red,
                        ),
                      ),
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  height: 200,width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Note",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: true,
                          controller: _titleController,
                          decoration: InputDecoration(
                            hintText: "Title...",
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
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          autofocus: true,
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: "Description...",
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
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await noteHelper.insertNote(
                        _titleController.text,
                        _descriptionController.text,
                        false,
                      );
                      _titleController.clear();
                      _descriptionController.clear();
                      setState(() {});
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Add',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
