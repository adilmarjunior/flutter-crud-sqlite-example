import 'package:persistence_example/models/Contact.dart';
import 'package:sqflite/sqflite.dart';

import '../AppDatabase.dart';

class ContactDao
{
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
}