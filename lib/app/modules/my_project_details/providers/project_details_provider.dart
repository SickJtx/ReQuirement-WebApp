import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

import 'package:logger/logger.dart';
import 'package:re_quirement/app/utils/constants/http_info.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';
import 'package:url_launcher/url_launcher.dart';

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
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> editRequirement(
      {required String token,
      required String rid,
      required dynamic map}) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;
    logger.wtf("/requirement/$rid");
    logger.wtf(map);
    try {
      response = await _dio.patch(
        "/requirement/$rid",
        data: map,
      );
    } on DioError catch (e) {
      logger.e(e.response);
      throw Exception(e);
    }

    return response;
  }

  Future<Response> createRequirement({
    required String token,
    required String pid,
    required dynamic requirement,
  }) async {
    final selectedProject = await getProjetDetails(token: token, pid: pid);
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;
    final List<dynamic> data = [];

    data.add(
      {
        "systemDescription": requirement["systemDescription"].toString(),
        "actorDescription": requirement["actorDescription"].toString(),
        "actionDescription": requirement["actionDescription"].toString(),
        "requirementType": requirement["requirementType"].toString(),
        "detailsDescription": requirement["detailsDescription"].toString(),
        "productBacklogId":
            selectedProject.data["productBacklogs"][0]["id"] as int,
        "requirementPriorities": [
          {
            "priorityValue": "1",
            "priorityType": "Ranking",
            "profileUserId":
                int.parse(Get.find<SessionController>().userId.value),
          }
        ],
      },
    );

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

  Future<Response> exportProject({
    required String token,
    required String pid,
  }) async {
    final _dio = Dio();
    final Response response;
    _dio.options.headers = {"Authorization": "Bearer $token"};
    _dio.options.baseUrl = HttpInfo.url;

    try {
      response = await _dio.post(
        "/project/excel/$pid",
      );

      if (response.data["url"] != null) {
        await launch(response.data["url"].toString());
      }
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
      data.add(
        {
          "systemDescription": requirements[i]["systemDescription"].toString(),
          "actorDescription": requirements[i]["actorDescription"].toString(),
          "actionDescription": requirements[i]["actionDescription"].toString(),
          "requirementType": requirements[i]["requirementType"].toString(),
          "referenceId": requirements[i]["id"].toString(),
          "productBacklogId":
              selectedProject.data["productBacklogs"][0]["id"] as int,
          "requirementPriorities": [
            {
              "priorityValue": "1",
              "priorityType": "Ranking",
              "profileUserId":
                  int.parse(Get.find<SessionController>().userId.value),
            }
          ],
        },
      );
    }

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
