import 'package:get/get.dart';
import 'package:stack/stack.dart' as stk;

class NavbarController extends GetxController {
  final hovers = [false, false, false, false, false].obs;
  final viewFlags = [false, true, true, false, false].obs;

  final stk.Stack<int> pila = stk.Stack();

  final initiated = false.obs;

  final currentIndex = 1.obs;
  final previousIndex = 0.obs;

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

  }

  void startSesion() {
    viewFlags[currentIndex.value] = false;
    currentIndex.value = 2;
    onSesion.value = true;
    Get.offAndToNamed("/home");
    Get.offAndToNamed("/home");
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
