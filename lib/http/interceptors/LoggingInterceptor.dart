import 'package:flutter/cupertino.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('== == Request == ==');
    debugPrint('Url: ${data.url}');
    debugPrint('Method: ${data.method}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    debugPrint('== == ======== == ==');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('== == Response == ==');
    debugPrint('Status Code: ${data.statusCode}');
    debugPrint('Headers: ${data.headers}');
    debugPrint('Body: ${data.body}');
    debugPrint('== == ======== == ==');
    return data;
  }
}