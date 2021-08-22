import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class BaseRequest {
  late Dio dio;
  BaseRequest() {
    dio = Dio()
      ..options.connectTimeout = 10000
      ..options.receiveTimeout = 10000;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
}
