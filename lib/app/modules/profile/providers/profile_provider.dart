import 'dart:io';

import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class ProfileProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getUserInfo(
      {required String token, required String uid}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/profile-user/$uid",
      );
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }
}
