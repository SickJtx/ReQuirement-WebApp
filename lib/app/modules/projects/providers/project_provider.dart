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
      List<dynamic> tags = const [],
      List<dynamic> productBacklogs = const [],
      required int mkid,
      required String projectName}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;
    final dynamic a = {
      "projectName": projectName,
      "marketTypeId": mkid,
      "tags": tags,
      "productBacklogs": productBacklogs
    };
    logger.wtf(a);
    try {
      response = await _dio.post("/project", data: {
        "projectName": projectName,
        "marketTypeId": mkid,
        "tags": tags,
        "productBacklogs": productBacklogs
      });
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> generateProject(
      {required String token, required int mkid}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.post("/project/generate?marketTypeId=$mkid");
    } catch (e) {
      logger.e(e);
      throw Exception(e);
    }

    return response;
  }
}
