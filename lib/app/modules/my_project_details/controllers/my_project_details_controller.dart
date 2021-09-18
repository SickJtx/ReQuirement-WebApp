import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
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
  final tags = ["Uso libre", "Proyecto libre"].obs;
  final editor = false.obs;
  final RxBool loading = true.obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  dynamic map = {};

  Future getProjectInfo({required String pid}) async {
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProjectDetailsProvider()
          .getProjetDetails(token: ctrl.token.value, pid: pid);
      if (response.statusCode == 200) {
        logger.i(response.data);
        map = response.data;
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

  final requirements = [
    Requirement(
      codigo: "RF01",
      detalles:
          "Como usuario quiero iniciar sesión en el sistema para utilizar los servicios de reutilziación",
      fecha: DateTime.now(),
      prioridad: "Alta",
      puntos: 3,
    ),
    Requirement(
      codigo: "RF02",
      detalles:
          "Como usuario quiero crearme una cuenta en el sistema para utilizar los servicios de reutilziación",
      fecha: DateTime.now(),
      prioridad: "Alta",
      puntos: 3,
    ),
    Requirement(
      codigo: "RF03",
      detalles:
          "Como usuario quiero crearme una cuenta en el sistema para utilizar los servicios de reutilziación",
      fecha: DateTime.now(),
      prioridad: "Alta",
      puntos: 3,
    ),
    Requirement(
      codigo: "RF04",
      detalles:
          "Como usuario quiero crearme una cuenta en el sistema para utilizar los servicios de reutilziación",
      fecha: DateTime.now(),
      prioridad: "Alta",
      puntos: 3,
    )
  ].obs;

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
