import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/home/controllers/home_controller.dart';
import 'package:re_quirement/app/modules/login/providers/login_provider.dart';
import 'package:re_quirement/app/modules/profile/controllers/profile_controller.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final logger = Logger(
    printer: PrettyPrinter(),
  );
  final Rx<bool> keepOnline = false.obs;
  final Rx<bool> hoverText = false.obs;

  final Rx<String> token = "".obs;
  final RxBool loading = false.obs;

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController usernameController, passwordController;

  String email = '';
  String password = '';
  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future setPrefs() async {
    final ctrl = Get.find<SessionController>();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (keepOnline.value) {
      prefs.setBool("active", true);
    }
    prefs.setString("username", usernameController.text);
    prefs.setString("password", passwordController.text);
    prefs.setString("token", token.value);
    prefs.setString("userId", ctrl.userId.value);
  }

  Future getSesion() async {
    loading.value = true;
    dio.Response response;
    try {
      response = await LoginProvider()
          .getSession(usernameController.text, passwordController.text);
      logger.i(response.data);

      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);

        token.value = response.data["access_token"].toString();

        await getUserId();
        await setPrefs();
        await Get.find<HomeController>().getProjects();
        await Get.find<ProjectsController>().getProjects();
        await Get.find<ProjectsController>().getMarketTypes();
        final ctrl = Get.find<NavbarController>();
        ctrl.startSesion();

        loading.value = false;
      } else {
        logger.i(response.statusCode);
        loading.value = false;
      }
    } on Exception catch (e) {
      logger.e(e);
      loading.value = false;
    }
  }

  Future getSesionWithPrefs(String username, String password) async {
    dio.Response response;
    try {
      response = await LoginProvider().getSession(username, password);
      if (response.statusCode == 201 || response.statusCode == 200) {
        logger.i(response.data);

        token.value = response.data["access_token"].toString();
        Get.find<SessionController>().token.value = token.value;
        await getUserId();

        Get.find<NavbarController>().startSesion();

        Get.toNamed("/home");
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      logger.e(e);
    }
    final ctrl = Get.find<NavbarController>();
    ctrl.startSesion();
    Get.toNamed("/home");
  }

  Future getUserId() async {
    dio.Response response;
    try {
      response = await LoginProvider().getUserId(token.value);
      if (response.statusCode == 200) {
        logger.i(response.data);

        Get.find<SessionController>().setTokenUid(
            userId: response.data["userId"].toString(), token: token.value);

        Get.put(ProfileController());

        await Get.find<ProfileController>().getUserInfo();
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Email incorrecto';
    }
    return null;
  }

  String? validatePassword(String value) {
    const String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    final regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Ingresar contraseña';
    } else {
      if (!regex.hasMatch(value)) {
        return 'La contraseña debe tener al menos 8 caracteres y al menos una letra mayúscula, una letra minúscula, un número y un caracter especial';
      } else {
        return null;
      }
    }
  }

  bool checkLogin() {
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    loginFormKey.currentState!.save();
    return true;
  }
}
