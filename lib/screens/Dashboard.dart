import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistence_example/screens/TransactionList.dart';

import 'ContactList.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('images/bytebank_logo.png'),
          ),
          Container(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                _CardDashboard(
                  'Transfer',
                  Icons.monetization_on,
                  onClick: () => _sendToScreen(context, ContactList()),
                ),
                _CardDashboard(
                  'Transfer List',
                  Icons.description,
                  onClick: () => _sendToScreen(context, TransactionsList()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _sendToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      (MaterialPageRoute(
        builder: (context) => screen,
      )),
    );
  }
}

class _CardDashboard extends StatelessWidget {
  final Function onClick;
  final IconData icon; //Icons.people
  final String text; //'Contacts'

  _CardDashboard(this.text, this.icon, {required this.onClick}); //ContactList()

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => this.onClick(),
          child: Container(
            padding: EdgeInsets.all(8.0),
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 16.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
