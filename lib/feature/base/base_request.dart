import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class BaseRequest {
  BaseRequest._();

  static final BaseRequest instance = BaseRequest._();

  final Dio dio = _getDio();

  static _getDio() {
    Dio _dio = Dio()
      ..options.connectTimeout = 10000
      ..options.receiveTimeout = 10000;

    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient _client) {
      _client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return _client;
    };
    return _dio;
  }
}
