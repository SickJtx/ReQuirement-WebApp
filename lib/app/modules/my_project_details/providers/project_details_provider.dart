import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/state_manager.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';

class ProjectDetailsProvider {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future<Response> getProjetDetails(
      {required String token, required String pid}) async {
    logger.wtf("$pid,$token");
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.get(
        "/project/$pid",
      );
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> cloneRequirements({
    required String token,
    required String pid,
    required List<dynamic> requirements,
  }) async {
    final selectedProject = await getProjetDetails(token: token, pid: pid);
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;
    final List<dynamic> data = [];
    for (int i = 0; i < requirements.length; i++) {
      data.add({
        "systemDescription": requirements[i]["systemDescription"].toString(),
        "actorDescription": requirements[i]["actorDescription"].toString(),
        "actionDescription": requirements[i]["actionDescription"].toString(),
        "requirementType": requirements[i]["requirementType"].toString(),
        "productBacklogId":
            selectedProject.data["productBacklogs"][0]["id"] as int,
        "id": requirements[i]["id"].toString(),
      });
    }
    logger.wtf(data);
    try {
      response = await _dio.post(
        "/requirement",
        data: data,
      );
    } on DioError catch (e) {
      logger.e(e.response);

      throw Exception(e);
    }

    return response;
  }
}
