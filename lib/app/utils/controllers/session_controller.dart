import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/login/controllers/login_controller.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends GetxController {
  late final SharedPreferences prefs;

  final RxBool active = false.obs; //*Si hay una sesíon activa
  final RxString userId = "empty".obs;
  final RxString token = "empty".obs;

  final logger = Logger(
    printer: PrettyPrinter(),
  );
  @override
  void onInit() {
    initSharedPreferences();
    super.onInit();
  }

  bool setTokenUid({required String userId, required String token}) {
    this.token.value = token;
    this.userId.value = userId;
    logger.i("$token $userId");
    return true;
  }

  Future initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey("active") || !prefs.getBool("active")!) {
      setDefault();
    } else if (prefs.getBool("active")!) {
      userId.value = prefs.getString("userId")!;
      token.value = prefs.getString("token")!;
      await Get.find<LoginController>().getSesionWithPrefs();
    }
  }

  void loadSharedPreferences() {
    if (!prefs.containsKey("active")) Get.offAllNamed("/login");
    userId.value = prefs.getString("userId")!;
    token.value = prefs.getString("token")!;
    Get.find<NavbarController>().getCurrentIndex();
  }

  bool setDefault() {
    prefs.setBool("active", false);
    prefs.setString("userId", "empty");
    prefs.setString("token", "empty");
    return true;
  }

  bool deletePrefs() {
    prefs.remove("active");
    prefs.remove("userId");
    prefs.remove("token");
    return true;
  }
  /*
  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}*/
}
