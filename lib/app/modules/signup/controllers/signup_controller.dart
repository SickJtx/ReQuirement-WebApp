import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/signup/providers/singup_provider.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

class SignUpController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController primaryAddressController = TextEditingController();
  TextEditingController secundaryAddressController = TextEditingController();

  final RxBool loading = false.obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  Future signUpUser() async {
    loading.value = true;
    dio.Response response;

    try {
      response = await SignUpProvider().signUpUser(
        username: usernameController.text,
        password: passwordController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        primaryAddress: primaryAddressController.text,
        secundaryAddress: secundaryAddressController.text,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        Get.find<NavbarController>().changePage(1);
        logger.i(response.data);
      } else {
        logger.i(response.statusCode);
        loading.value = false;
      }
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }

    loading.value = false;
  }

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
