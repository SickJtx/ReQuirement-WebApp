import 'dart:typed_data';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/projects/providers/market_type_provider.dart';
import 'package:re_quirement/app/modules/projects/providers/project_provider.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';
import 'package:re_quirement/app/utils/services/file_picker.dart';

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

  final tipoMercado = "".obs;
  final visibilidadProyecto = "".obs;

  final RxList<dynamic> newTags = [].obs;
  //final RxList<dynamic> productBacklog = [].obs;

  final RxList<dynamic> projects = [].obs;
  final RxList<dynamic> marketType = [].obs;
  final RxList<dynamic> tags = [].obs;
  final RxList<dynamic> avaiableMarketType = [].obs;

  final qProjects = 0.obs;

  final RxList<RxBool> isSelected = <RxBool>[].obs;
  final RxList<int> selectedRequirements = <int>[].obs;
  final qSelectedItems = 0.obs;
  final RxList<dynamic> generatedRequirements = [].obs;

  final RxBool loading = false.obs;
  final RxBool generatorLoading = true.obs;
  final mkid = 0.obs;

  GlobalKey<FormState> projectsStep1FormKey = GlobalKey<FormState>();

  final RxBool autoGenerate = false.obs;

  final filePath = Uint8List(0).obs;
  final FileUploader fileUploader = FileUploader();

  String projectName = '';
  String tagName = '';

  final logger = Logger(
    printer: PrettyPrinter(),
  );
  void clearLists() {
    newTags.clear();
    isSelected.clear();
    selectedRequirements.clear();
    qSelectedItems.value = 0;
  }

  void clearForms() {
    tipoMercado.value = Get.find<SessionController>().myLocale!.selectTypeStep1;
    visibilidadProyecto.value =
        Get.find<SessionController>().myLocale!.visibilityPublicStep1;
    projectNameController.text = "";
    tagNameController.text = "";
    newTags.clear();
    //productBacklog.clear();
    isSelected.clear();
    selectedRequirements.clear();
    qSelectedItems.value = 0;
    autoGenerate.value = false;
    step.value = 1;
  }

  void newTag() {
    bool added = false;
    int id = 0;
    if (tagNameController.text != "") {
      for (final dynamic i in tags) {
        if (tagNameController.text == i["tagDescription"].toString()) {
          id = i["id"] as int;
          added = true;
        }
      }
      if (added) {
        newTags.add({'tagDescription': tagNameController.text, 'id': id});
      } else {
        newTags.add({'tagDescription': tagNameController.text});
      }
      tagNameController.text = "";
    }
  }

/*  */
  void getMkid() {
    for (final dynamic mt in marketType) {
      if (mt["marketTypeName"].toString() == tipoMercado.value) {
        mkid.value = mt["id"] as int;
      }
    }
  }

  List<dynamic> getSelectedRequirements() {
    final List<dynamic> selectedRequirementList = [];
    for (final int i in selectedRequirements) {
      selectedRequirementList.add({
        "systemDescription": "System",
        "actorDescription": "Actor",
        "actionDescription": generatedRequirements[i],
        "requirementType": "FUNCTIONAL"
      });
    }
    return selectedRequirementList;
  }

  List<String> dropdownItems() {
    final List<String> list = <String>[];
    list.add(Get.find<SessionController>().myLocale!.selectTypeStep1);
    for (final dynamic mt in marketType) {
      list.add(mt["marketTypeName"].toString());
    }
    return list;
  }

  List<String> dropdownAvaiableItems() {
    final List<String> list = <String>[];
    list.add(Get.find<SessionController>().myLocale!.selectTypeStep1);
    for (final dynamic mt in avaiableMarketType) {
      list.add(mt["marketType"]["marketTypeName"].toString());
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
        qProjects.value = projects.value.length;
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

  Future generateRequirements() async {
    generatedRequirements.clear();
    isSelected.clear();
    generatorLoading.value = true;
    dio.Response response;
    getMkid();
    try {
      response =
          await ProjectsProvider().generateRequirements(mkid: mkid.value);
      if (response.statusCode == 201 || response.statusCode == 200) {
        generatedRequirements.value = response.data["data"] as List;
        for (int i = 0; i < generatedRequirements.value.length; i++) {
          isSelected.value.add(false.obs);
        }
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
      generatorLoading.value = false;
    } on Exception catch (e) {
      generatorLoading.value = false;
      logger.e(e);
    }
  }
  /* Future generateProject() async {
    generatedRequirements.clear();
    isSelected.clear();
    generatorLoading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    getMkid();
    try {
      response = await ProjectsProvider()
          .generateProject(token: token, mkid: mkid.value);
      if (response.statusCode == 201 || response.statusCode == 200) {
        generatedRequirements.value =
            response.data["productBacklogs"][0]["requirements"] as List;
        for (int i = 0; i < generatedRequirements.value.length; i++) {
          isSelected.value.add(false.obs);
        }
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
      }
      generatorLoading.value = false;
    } on Exception catch (e) {
      generatorLoading.value = false;
      logger.e(e);
    }
  } */

  Future createProject() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    getMkid();
    try {
      Get.back();
      response = await ProjectsProvider().createProject(
        token: token,
        mkid: mkid.value,
        tags: newTags,
        projectName: projectNameController.text,
        productBacklogs: [
          {
            "productBacklogName": "Product Backlog",
            "requirements": getSelectedRequirements()
          }
        ],
      );
      clearForms();
      if (response.statusCode == 201 || response.statusCode == 200) {
        await getProjects();
        await getTags();
        step.value = 1;
        logger.i(response.data);
        Get.snackbar(
          "Aviso",
          "Proyecto creado correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      } else {
        logger.i(response.statusCode);
        Get.snackbar(
          "Aviso",
          "Ah ocurrido un error, revise los datos o intente más tarde",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      }
      loading.value = false;
    } on Exception catch (e) {
      clearForms();
      loading.value = false;
      logger.e(e);
    }
  }

  Future importProject() async {
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;

    final bool succes = await fileUploader.selectFile();

    if (succes) {
      try {
        response = await fileUploader.importProject(token: token);
        clearForms();
        if (response.statusCode == 201 || response.statusCode == 200) {
          await getProjects();
          await getTags();
          step.value = 1;
          logger.i(response.data);
          Get.snackbar(
            "Aviso",
            "Proyecto importando correctamente",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: active.withOpacity(0.5),
          );
        } else {
          Get.snackbar(
            "Aviso",
            "Ocurrió un problema al importar el proyecto, revise el documento o intente más tarde",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: active.withOpacity(0.5),
          );
          logger.i(response.statusCode);
        }
        loading.value = false;
      } on Exception catch (e) {
        clearForms();
        loading.value = false;
        logger.e(e.toString());
      }
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

  Future deleteProject(int id) async {
    loading.value = true;

    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await ProjectsProvider().deleteProjects(
        token: token,
        projectId: id,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        await getProjects();
        logger.i(response.data);
        Get.snackbar(
          "Aviso",
          "Se eliminó el proyecto",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      } else {
        Get.snackbar(
          "Aviso",
          "Ocurrió un problema, intente más tarde",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
        logger.i(response.statusCode);
      }
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  Future getTags() async {
    tags.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await MarketTypeProvider().getTags(
        token: token,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        tags.value = response.data as List;

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

  Future getAvaiableMarketTypes() async {
    avaiableMarketType.clear();
    loading.value = true;
    final String token = Get.find<SessionController>().token.value;
    dio.Response response;
    try {
      response = await MarketTypeProvider().getAvaliableMarketTypes(
        token: token,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        avaiableMarketType.value = response.data as List;
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
    if (value.isEmpty) {
      return 'El nombre del proyecto no puede estar vacío';
    }
    return null;
  }

  String? validateTagName(String value) {
    if (value.isEmpty) {
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

  /* bool validTag() {
    final isValid = projectsStep2FormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    projectsStep2FormKey.currentState!.save();
    return true;
  } */

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
