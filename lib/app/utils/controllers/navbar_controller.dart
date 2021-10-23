import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:stack/stack.dart' as stk;

class NavbarController extends GetxController {
  final hovers = [false, false, false, false, false].obs;
  final viewFlags = [false, true, true, false, false].obs;

  final stk.Stack<int> pila = stk.Stack();
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final initiated = false.obs;

  final currentIndex = 1.obs;
  final previousIndex = 0.obs;
  final path = "".obs;

  final onSesion = false.obs;
  final List<String> routes = [
    '/signin',
    '/login',
    '/home',
    '/projects',
    '/profile',
  ];
  Future<void> changePage(int index) async {
    if (!viewFlags[index]) {
      viewFlags[currentIndex.value] = false;
      pila.push(currentIndex.value);
      currentIndex.value = index;
      viewFlags[index] = true;
    }
    Get.offAndToNamed(routes[index]);

    path.value = Uri.base
        .toString()
        .replaceAll(Uri.base.origin, "")
        .replaceAll("/#", "");
  }

  void startSesion() {
    viewFlags[currentIndex.value] = false;
    currentIndex.value = 2;
    onSesion.value = true;
    path.value = routes[currentIndex.value];
    Get.offAndToNamed("/home");
    Get.offAndToNamed("/home");
  }

  void showCurrent() {
    logger.wtf(currentIndex.value.toString() + path.value);
    if (path.value == "") {
      Get.toNamed("/login");
      Get.toNamed("/login");
    }
  }

  void getCurrentIndex() {
    path.value = Uri.base
        .toString()
        .replaceAll(Uri.base.origin, "")
        .replaceAll("/#", "");

    for (int i = 0; i < 5; i++) {
      viewFlags[i] = false;

      if (routes[i] == path.value) currentIndex.value = i;
    }
    viewFlags[currentIndex.value] = true;
  }

  @override
  void onInit() {
    super.onInit();
  }
/*
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}*/
}
