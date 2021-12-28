import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class EditNoteScreen extends StatelessWidget {
  final int index;
  EditNoteScreen({Key? key, required this.index}) : super(key: key);

  final _notes = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
