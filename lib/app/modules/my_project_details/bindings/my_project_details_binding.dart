import 'package:get/get.dart';

import '../controllers/my_project_details_controller.dart';

class MyProjectDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyProjectDetailsController>(
      () => MyProjectDetailsController(),
    );
  }
}
