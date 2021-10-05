import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/my_project_details/providers/project_details_provider.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class Requirement {
  Requirement({
    required this.codigo,
    required this.detalles,
    required this.prioridad,
    required this.fecha,
    required this.puntos,
  });

  final String? detalles;
  final String? prioridad;
  final DateTime? fecha;
  final int? puntos;
  final String? codigo;
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
  final RxList<Requirement> requirements = <Requirement>[].obs;

  final projectName = "".obs;
  final projectMarketTypeName = "".obs;
  final visibility = "".obs;
  final tags = [].obs;

  final qSelectedItems = 0.obs;
  final RxList<RxBool> isSelected = <RxBool>[].obs;
  final RxList<int> selectedRequirements = <int>[].obs;
  final selectedProjectName = "Seleccionar proyecto".obs;
  final selectedProjectid = "0".obs;
  void clearList() {
    tags.clear();
    //productBacklog.clear();
    for (RxBool i in isSelected) {
      i.value = false;
    }
    selectedProjectName.value = "Seleccionar proyecto";
    selectedRequirements.clear();
    qSelectedItems.value = 0;
  }

  void setInfo() {
    tags.clear();
    projectName.value = projectInfo["projectName"].toString();
    projectMarketTypeName.value =
        projectInfo["marketType"]["marketTypeName"].toString();
    visibility.value = projectInfo["visibility"].toString() == "PUBLIC"
        ? "Público"
        : "Privado";
    logger.wtf(projectInfo["tags"]);
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
      } else {
        logger.i(response.statusCode);
        Get.back();
        clearList();
      }
      loading.value = false;
    } on Exception catch (e) {
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
    if (requirementList.value.isNotEmpty) {
      for (int i = 0; i < requirementList.value.length; i++) {
        isSelected.value.add(false.obs);

        requirements.add(
          Requirement(
            codigo: (i > 9) ? "RF$i" : "RF0$i",
            detalles: toBeginningOfSentenceCase(
                requirementList.value[i]["actionDescription"].toString()),
            fecha: DateTime.now(),
            prioridad: "Alta",
            puntos: 3,
          ),
        );
      }
    }
  }

  List<String> dropdownItems() {
    final List<String> list = <String>[];
    list.add("Seleccionar proyecto");
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
