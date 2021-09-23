import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/my_project_details/providers/project_details_provider.dart';
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
  final RxList<Requirement> requirements = <Requirement>[].obs;

  final projectName = "".obs;
  final projectMarketTypeName = "".obs;
  final visibility = "".obs;
  final tags = [].obs;

  void setInfo() {
    tags.clear();
    projectName.value = projectInfo["projectName"].toString();
    projectMarketTypeName.value =
        projectInfo["marketType"]["marketTypeName"].toString();
    visibility.value = projectInfo["visibility"].toString() == "PUBLIC"
        ? "Público"
        : "Privado";
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
        setInfo();
        loadRequirements();
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

  void loadRequirements() {
    requirements.value.clear();
    final List<dynamic> list =
        projectInfo["productBacklogs"][0]["requirements"] as List;
    for (int i = 0; i < list.length; i++) {
      requirements.value.add(
        Requirement(
          codigo: (i > 9) ? "RF$i" : "RF0$i",
          detalles: toBeginningOfSentenceCase(
              list[i]["systemDescription"].toString()),
          fecha: DateTime.now(),
          prioridad: "Alta",
          puntos: 3,
        ),
      );
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
