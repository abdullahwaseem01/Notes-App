import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:notable/models/note.dart';

class AddNoteScreen extends StatelessWidget {
  static const String id = 'add_note_screen';
  AddNoteScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  void _submit(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      final notes = Hive.box('notes');
      final note = Note(
        title: _titleController.text.trim(),
        body: _bodyController.text.trim(),
        date: DateTime.now(),
      );
      notes.add(note);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Note',
          style: TextStyle(fontFamily: 'Satisfy'),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _titleController,
                  cursorColor: Colors.yellow[700],
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Title'),
                  validator: (value) => value != null && value.trim().length > 0
                      ? null
                      : 'Feild cannot be empty',
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: _bodyController,
                  cursorColor: Colors.yellow[700],
                  decoration: InputDecoration(
                      border: InputBorder.none, hintText: 'Body'),
                  validator: (value) => value != null && value.trim().length > 0
                      ? null
                      : 'Feild cannot be empty',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.yellow[700])),
                    onPressed: () => _submit(context),
                    child: Text(
                      'SUBMIT',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
