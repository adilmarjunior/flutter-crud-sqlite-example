import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:persistence_example/models/Transaction.dart';

import 'interceptors/LoggingInterceptor.dart';

final InterceptedClient client =
    InterceptedClient.build(interceptors: [LoggingInterceptor()]);

final Uri uri = Uri(
    scheme: 'http', port: 8080, host: '192.168.0.172', path: 'transactions');

Future<Transaction> insert(Transaction transaction) async {
  final Response response = await client.post(
    uri,
    headers: {
      'Content-type' : 'application/json',
      'password' : '1000'
    },
    body: jsonEncode(transaction.toJson())
  );

  final Map<String, dynamic> bodyDecoded = jsonDecode(response.body);
  final Transaction transactionInserted = Transaction.fromJson(bodyDecoded);

  return transactionInserted;
}

Future<List<Transaction>> findAll() async {
  final Response response = await client.get(uri).timeout(Duration(seconds: 5));
  List<dynamic> transactionsDecoded = jsonDecode(response.body);

  return transactionsDecoded.map((json) => Transaction.fromJson(json)).toList();
}
