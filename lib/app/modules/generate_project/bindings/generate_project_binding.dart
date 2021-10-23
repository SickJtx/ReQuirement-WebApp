import 'package:get/get.dart';

import '../controllers/generate_project_controller.dart';

class GenerateProjectBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GenerateProjectController>(
      () => GenerateProjectController(),
    );
  }
}
