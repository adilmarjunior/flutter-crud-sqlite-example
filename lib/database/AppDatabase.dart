import 'package:path/path.dart';
import 'package:persistence_example/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> createDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String completePath = join(dbPath, 'bytebank.db');
  return openDatabase(
    completePath,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
    //onDowngrade: onDatabaseDowngradeDelete,
  );
}
