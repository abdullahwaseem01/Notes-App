import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notable/models/note.dart';
import 'package:notable/screens/add_note_screen.dart';
import 'package:notable/screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(NoteAdapter());
  runApp(
    const Notable(),
  );
}

class Notable extends StatelessWidget {
  const Notable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.black, centerTitle: false, elevation: 0),
          scaffoldBackgroundColor: Colors.black),
      routes: {
        AddNoteScreen.id: (context) => AddNoteScreen(),
      },
      home: FutureBuilder(
        future: Hive.openBox('notes'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Scaffold(
                backgroundColor: Colors.black,
                body: Center(
                  child: Text('An error has occured'),
                ),
              );
            }
            return HomeScreen();
          } else {
            return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
