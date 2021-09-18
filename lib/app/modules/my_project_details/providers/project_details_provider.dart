import 'dart:io';

import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class ProjectDetailsProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getProjetDetails(
      {required String token, required String pid}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/project/$pid",
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
