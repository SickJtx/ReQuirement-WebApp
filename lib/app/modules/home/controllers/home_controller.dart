import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/home/providers/home_provider.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  final listKey = GlobalKey<AnimatedListState>();

  final RxList<dynamic> projects = [].obs;
  final RxBool loading = false.obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future getProjects() async {
    projects.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await HomeProvider().getProjects(
        token: token,
        limit: 10,
        page: 0,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        projects.value = response.data["results"] as List;
        update();
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
