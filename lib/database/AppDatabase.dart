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

Future<int> saveContact(Contact contact) async {
  final Database database = await createDatabase();
  final Map<String, dynamic> contactMap = Map();

  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;

  return database.insert('contacts', contactMap);
}

Future<List<Contact>> findAll() async {
  final Database database = await createDatabase();
  final List<Map<String, Object?>> queryResult = await database.query('contacts');
  final List<Contact> contacts = List.empty(growable: true);

  for (Map<String, dynamic> map in queryResult) {
    final Contact contact = Contact(
      map['id'],
      map['name'],
      map['account_number'],
    );
    contacts.add(contact);
  }

  return contacts;
}
