import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/projects/providers/market_type_provider.dart';
import 'package:re_quirement/app/modules/projects/providers/project_provider.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class AgileProject {
  AgileProject({
    required this.titulo,
    required this.tipo,
    required this.fecha,
    required this.cantidad,
    required bool? visibilidad,
  }) {
    this.visibilidad.value = visibilidad!;
  }

  final String? titulo;
  final String? tipo;
  final DateTime? fecha;
  final int? cantidad;
  final Rx<bool> visibilidad = false.obs;
}

class ProjectsController extends GetxController {
  TextEditingController projectNameController = TextEditingController();
  TextEditingController tagNameController = TextEditingController();
  final listKey = GlobalKey<AnimatedListState>();

  RxInt step = 1.obs;

  final tipoMercado = "Seleccionar tipo".obs;
  final visibilidadProyecto = "Público".obs;

  final RxList<dynamic> tags = [].obs;
  final RxList<dynamic> projects = [].obs;
  final RxList<dynamic> marketType = [].obs;
  final RxBool loading = false.obs;
  final mkid = "0".obs;

  GlobalKey<FormState> projectsStep1FormKey = GlobalKey<FormState>();
  GlobalKey<FormState> projectsStep2FormKey = GlobalKey<FormState>();
  String projectName = '';
  String tagName = '';

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  void newTag() {
    if (tagNameController.text != "") {
      tags.add({'tagDescription': tagNameController.text});
      tagNameController.text = "";
    }
  }

  void getMkid() {
    for (final dynamic mt in marketType) {
      if (mt["marketTypeName"].toString() == tipoMercado.value) {
        mkid.value = mt["id"].toString();
      }
    }
  }

  List<String> dropdownItems() {
    final List<String> list = <String>[];
    list.add("Seleccionar tipo");
    for (final dynamic mt in marketType) {
      list.add(mt["marketTypeName"].toString());
    }
    return list;
  }

  Future getProjects() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await ProjectsProvider().getProjects(
        token: token,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        projects.clear();
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

  Future createProject() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    getMkid();

    try {
      response = await ProjectsProvider().createProject(
          token: token, mkid: 31, tags: tags, projectName: "Test2");
      Get.back();
      if (response.statusCode == 201 || response.statusCode == 200) {
        await getProjects();
        step.value = 1;
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

  Future getMarketTypes() async {
    marketType.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await MarketTypeProvider().getMarketTypes(
        token: token,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        marketType.value = response.data as List;
        logger.wtf(marketType);
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

  String? validateProjectName(String value) {
    if (value.length <= 0) {
      return 'El nombre del proyecto no puede estar vacío';
    }
    return null;
  }

  String? validateTagName(String value) {
    if (value.length <= 0) {
      return 'El nombre del tag no puede estar vacío';
    }
    return null;
  }

  bool validStep1() {
    final isValid = projectsStep1FormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    projectsStep1FormKey.currentState!.save();
    return true;
  }

  bool validTag() {
    final isValid = projectsStep2FormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    projectsStep2FormKey.currentState!.save();
    return true;
  }
  /*
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}*/

}
