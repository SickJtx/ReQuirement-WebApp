import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/my_project_details/providers/project_details_provider.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class Requirement {
  Requirement({
    required this.codigo,
    required this.detalles,
    required this.prioridad,
    required this.fecha,
    required this.puntos,
    required this.actor,
    required this.goal,
    required this.type,
    required this.id,
  });

  String? id;
  String? detalles;
  String? actor;
  String? goal;
  String? type;
  String? prioridad;
  DateTime? fecha;
  int? puntos;
  String? codigo;
}

class MyProjectDetailsController extends GetxController {
  //TODO: Implement MyProjectDetailsController

  final editor = false.obs;
  final RxBool loading = true.obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  dynamic projectInfo = {}.obs;
  final RxList<dynamic> requirementList = [].obs;

  final RxInt indexDetails = 0.obs;

  final RxList<Requirement> requirements = <Requirement>[].obs;

  final projectName = "".obs;
  final projectMarketTypeName = "".obs;
  final visibility = "".obs;
  final userOwnerId = "".obs;
  final tags = [].obs;

  final qSelectedItems = 0.obs;
  final RxList<RxBool> isSelected = <RxBool>[].obs;
  final RxList<int> selectedRequirements = <int>[].obs;
  final selectedProjectName = "Seleccione un proyecto".obs;
  final selectedProjectid = "0".obs;

  TextEditingController editingController = TextEditingController();

  TextEditingController actorController = TextEditingController();
  TextEditingController actionController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController typeController = TextEditingController();

  final projectType = "FUNCTIONAL".obs;

  final editingIndex = 0.obs;
  final RxList<RxBool> isEditing =
      [false.obs, false.obs, false.obs, false.obs].obs;

  void cleanEditables() {
    for (int i = 0; i < isEditing.length; i++) {
      isEditing[i].value = false;
    }
  }

  void cleanControllers() {
    actorController.text = "";
    actionController.text = "";
    descriptionController.text = "";
    editingController.text = "";
  }

  void setIndexEdited(String code) {
    for (int i = 0; i < requirements.length; i++) {
      if (requirements[i].codigo == code) editingIndex.value = i;
    }
  }

  void setControllers({required Requirement value}) {
    actorController.text = value.actor!;
    actionController.text = value.detalles!;
    descriptionController.text = value.goal!;
  }

  void startEditing({required int index}) {
    cleanEditables();

    isEditing[index].value = true;
  }

  void clearList() {
    tags.clear();
    //productBacklog.clear();
    for (final RxBool i in isSelected) {
      i.value = false;
    }
    selectedProjectName.value = "Seleccione un proyecto";
    selectedRequirements.clear();
    qSelectedItems.value = 0;
  }

  void setInfo() {
    clearList();
    tags.clear();
    projectName.value = projectInfo["projectName"].toString();
    projectMarketTypeName.value =
        projectInfo["marketType"]["marketTypeName"].toString();
    visibility.value = projectInfo["visibility"].toString() == "PUBLIC"
        ? Get.find<SessionController>().myLocale!.visibilityPublicStep1
        : Get.find<SessionController>().myLocale!.visibilityPrivateStep1;
    userOwnerId.value = projectInfo["profileUserId"].toString();

    tags.value = projectInfo["tags"] as List;
  }

  Future getProjectInfo({required String pid}) async {
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider()
          .getProjetDetails(token: ctrl.token.value, pid: pid);

      if (response.statusCode == 200) {
        logger.i(response.data);
        projectInfo.value = response.data;
        loadRequirements();
        setInfo();
      } else {
        logger.i(response.statusCode);
        Get.back();
      }
      loading.value = false;
    } on Exception catch (e) {
      logger.e(e);
      Get.back();
    }
  }

  List<dynamic> getSelectedRequirements() {
    final List<dynamic> selectedRequirementList = [];
    for (final int i in selectedRequirements) {
      selectedRequirementList.add(requirementList[i]);
    }
    return selectedRequirementList;
  }

  Future createRequirements() async {
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider().createRequirement(
        token: ctrl.token.value,
        pid: projectInfo["id"].toString(),
        requirement: {
          "systemDescription": "System",
          "actorDescription": actorController.text,
          "actionDescription": actionController.text,
          "requirementType": projectType.value,
          "detailsDescription": descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        logger.i(response.data);
        Get.snackbar(
          "Aviso",
          "Requisito agregado correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      } else {
        Get.snackbar(
          "Aviso",
          "Requisito agregado correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
        logger.i(response.statusCode);
        Get.back();
      }
      loading.value = false;
    } on Exception catch (e) {
      Get.snackbar(
        "Aviso",
        "Ah ocurrido un error, intentelo más tarde",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: active.withOpacity(0.5),
      );
      logger.e(e);
      Get.back();
      loading.value = false;
    }
  }

  Future editRequirements(String id) async {
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider().editRequirement(
        token: ctrl.token.value,
        rid: id,
        map: {
          "actorDescription": actorController.text,
          "actionDescription": actionController.text,
          "detailsDescription": descriptionController.text,
        },
      );

      if (response.statusCode == 200) {
        logger.i(response.data);
        Get.snackbar(
          "Aviso",
          "Requisito editado correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
        getProjectInfo(pid: projectInfo["id"].toString());
      }
      loading.value = false;
    } on Exception catch (e) {
      Get.snackbar(
        "Aviso",
        "Ah ocurrido un error, intentelo más tarde",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: active.withOpacity(0.5),
      );
      logger.e(e);
      Get.back();
      loading.value = false;
    }
  }

  Future exportProject() async {
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider().exportProject(
        token: ctrl.token.value,
        pid: projectInfo["id"].toString(),
      );

      if (response.statusCode == 200) {
        logger.i(response.data);
        Get.snackbar(
          "Aviso",
          "Se ah exportado el proyecto correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      } else {
        Get.snackbar(
          "Aviso",
          "Se ah exportado el proyecto correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
        logger.i(response.statusCode);
      }
      loading.value = false;
    } on Exception catch (e) {
      Get.snackbar(
        "Aviso",
        "Ah ocurrido un error, intentelo más tarde",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: active.withOpacity(0.5),
      );
      logger.e(e);
      loading.value = false;
    }
  }

  Future cloneRequirements() async {
    getSelectedProjectId();
    loading.value = true;
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider().cloneRequirements(
          token: ctrl.token.value,
          pid: selectedProjectid.value,
          requirements: getSelectedRequirements());

      if (response.statusCode == 200) {
        logger.i(response.data);
        clearList();
        Get.back();
        Get.snackbar(
          "Aviso",
          "Se clonaron los requisitos correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
      } else {
        Get.back();
        Get.snackbar(
          "Aviso",
          "Se clonaron los requisitos correctamente",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: active.withOpacity(0.5),
        );
        logger.i(response.statusCode);
      }
      //Get.back();
      clearList();
      loading.value = false;
    } on Exception catch (e) {
      Get.snackbar(
        "Aviso",
        "Ocurrió un error, intentelo más tarde",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: active.withOpacity(0.5),
      );
      logger.e(e);
      Get.back();
      loading.value = false;
    }
  }

  void loadRequirements() {
    clearList();
    isSelected.clear();
    requirements.clear();
    requirementList.clear();
    requirementList.value = [
      ...projectInfo["productBacklogs"][0]["requirements"] as List
    ];
    // ignore: invalid_use_of_protected_member
    if (requirementList.value.isNotEmpty) {
      for (int i = 0; i < requirementList.value.length; i++) {
        isSelected.value.add(false.obs);

        requirements.add(
          Requirement(
            id: requirementList.value[i]["id"].toString(),
            codigo: (i > 9) ? "RF$i" : "RF0$i",
            detalles: toBeginningOfSentenceCase(
                requirementList.value[i]["actionDescription"].toString()),
            fecha: DateTime.now(),
            prioridad: "High",
            puntos: 3,
            actor: requirementList.value[i]["actorDescription"].toString(),
            goal: requirementList.value[i]["detailsDescription"].toString() ==
                    "null"
                ? Get.find<SessionController>().myLocale!.notDefined
                : requirementList.value[i]["detailsDescription"].toString(),
            type: requirementList.value[i]["requirementType"].toString() ==
                    "FUNCTIONAL"
                ? Get.find<SessionController>().myLocale!.functionalReq
                : Get.find<SessionController>().myLocale!.nonFunctionalReq,
          ),
        );
      }
    }
  }

  List<String> dropdownItems() {
    final List<String> list = <String>[];
    list.add("Seleccione un proyecto");
    final projects = Get.find<ProjectsController>().projects;
    for (final dynamic p in projects) {
      if (p["id"] != projectInfo["id"]) list.add(p["projectName"].toString());
    }
    return list;
  }

  void getSelectedProjectId() {
    final projects = Get.find<ProjectsController>().projects;
    for (final dynamic p in projects) {
      if (p["projectName"] == selectedProjectName.value) {
        selectedProjectid.value = p["id"].toString();
      }
    }
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
  void onClose() {}
  */
}
