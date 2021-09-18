import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class ProjectsProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getProjects({
    required String token,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/project/profile-user",
      );
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> createProject(
      {required String token,
      required List<dynamic> tags,
      required int mkid,
      required String projectName}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.post("/project",
          data: {"projectName": projectName, "marketTypeId": mkid, 'tags': tags});
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
