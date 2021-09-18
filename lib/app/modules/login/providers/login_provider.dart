import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class LoginProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getSession(String username, String password) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.post(
        "/session/login",
        data: {
          'username': username,
          'password': password,
        },
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> getUserId(String token) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/session/profile",
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
