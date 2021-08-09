import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:toannm_test/feature/const/app_const.dart';
import 'package:toannm_test/feature/user/model/response.dart';

class UserRepository {
  final Dio dio;

  UserRepository(this.dio) {
    dio.options.connectTimeout = 10000;
    dio.options.receiveTimeout = 10000;

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<UserResponse> getUsers(int pageNumber) async {
    var response = await dio
        .get(AppConst.urlGetUrl, queryParameters: {"page": pageNumber});
    return UserResponse.fromJson(response.data);
  }
}
