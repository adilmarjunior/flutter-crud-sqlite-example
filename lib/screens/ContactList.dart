import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistence_example/database/dao/ContactDao.dart';
import 'package:persistence_example/models/Contact.dart';

import 'ContactForm.dart';
import 'TransactionForm.dart';

class ContactList extends StatefulWidget {
  ContactList ({Key? key}) : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactDao _contactDao = ContactDao();
  final List<Contact> contacts = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: List.empty(),
        future: Future.delayed(Duration(seconds: 1)).then((value) => _contactDao.findAll()),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return Text('Unkown error');
          }

          if (snapshot.data!.isEmpty){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Loading'),
                ],
              ),
            );
          }

          List<Contact> contacts = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index) {
              final Contact contact = contacts[index];
              return _ContactItem(contact, onClick: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TransactionForm(contact),
                  ),
                );
              },);
            },
            itemCount: contacts.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ContactForm(),
            ),
          );
          setState(() { });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  _ContactItem(this.contact, {required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => this.onClick(),
        title: Text(
          contact.name,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}

/*switch (snapshot.connectionState) {
case ConnectionState.none:
break;
case ConnectionState.waiting:
return Center(
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: <Widget>[
CircularProgressIndicator(),
Text('Loading'),
],
),
);
case ConnectionState.active:
break;
case ConnectionState.done:
List<Contact> contacts = snapshot.data!;
return ListView.builder(
itemBuilder: (context, index) {
final Contact contact = contacts[index];
return _ContactItem(contact);
},
itemCount: contacts.length,
);
}
return Text('Unkown error');*/
