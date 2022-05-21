import 'package:flutter/material.dart';
import 'package:persistence_example/screens/Dashboard.dart';

import 'http/TransactionClient.dart';
import 'models/Contact.dart';
import 'models/Transaction.dart';

void main() {
  runApp(PersistenceApp());
  findAll();
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