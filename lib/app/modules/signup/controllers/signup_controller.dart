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

  GlobalKey<FormState> signupFormKey =new GlobalKey<FormState>();

  String firstName = '';
  String lastName = '';
  String username = '';
  String password = '';
  String repeatPassword = '';
  String primaryAddress = '';
  String secondaryAddress = '';

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

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Email incorrecto';
    }
    return null;
  }

  String? validateOnlyLetters(String value) {
    if (!GetUtils.isAlphabetOnly(value)) {
      return 'Solo usar caracteres alfabéticos';
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

  String? validateAdress(String value) {
    if (value.length <= 0) {
      return 'La dirección no puede estar vacía';
    }
    return null;
  }

  String? validateRetypePassword(String value) {
    if (value != this.passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  bool checkSignup() {
    final isValid = signupFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    signupFormKey.currentState!.save();
    return true;
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
