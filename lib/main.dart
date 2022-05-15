import 'package:flutter/material.dart';
import 'package:persistence_example/database/AppDatabase.dart';
import 'package:persistence_example/screens/ContactForm.dart';
import 'package:persistence_example/screens/Dashboard.dart';

import 'models/Contact.dart';

void main() {
  runApp(PersistenceApp());
  saveContact(Contact(0, 'Maria Jose', 2000)).then((id) {
    findAll().then((contacts) => debugPrint(contacts.toString()));
  });
}

class PersistenceApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          accentColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          )
      ),
      home: Dashboard(),
    );
  }
}