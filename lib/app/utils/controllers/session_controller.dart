import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/login/controllers/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionController extends GetxController {
  late final SharedPreferences prefs;

  final RxBool active = false.obs; //*Si hay una sesíon activa
  final RxString username = "empty".obs;
  final RxString password = "empty".obs;
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

    if (!prefs.containsKey("active")) {
      setDefault();
    } else if (prefs.getBool("active")!) {
      username.value = prefs.getString("username")!;
      password.value = prefs.getString("password")!;
      userId.value = prefs.getString("userId")!;
      await Get.find<LoginController>()
          .getSesionWithPrefs(username.value, password.value);
    }
  }

  bool setDefault() {
    prefs.setBool("active", false);
    prefs.setString("username", "empty");
    prefs.setString("password", "empty");
    prefs.setString("userId", "empty");
    prefs.setString("token", "empty");
    return true;
  }

  bool deletePrefs() {
    prefs.remove("active");
    prefs.remove("username");
    prefs.remove("password");
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
