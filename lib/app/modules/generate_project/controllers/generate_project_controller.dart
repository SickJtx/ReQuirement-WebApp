import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GenerateProjectController extends GetxController {
  //TODO: Implement GenerateProjectController
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final RxList<dynamic> tags = [].obs;

  final RxBool loading = false.obs;
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
