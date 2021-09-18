import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/profile/providers/profile_provider.dart';
import 'package:re_quirement/app/modules/profile/user_profile_model.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class ProfileController extends GetxController {
  UserProfile user = UserProfile(
    email: "empty".obs,
    firstName: "empty".obs,
    lastName: "empty".obs,
    locationCode: "empty".obs,
    locationDescription: "empty".obs,
    primaryAddress: "empty".obs,
    secundaryAddress: "empty".obs,
    suscribed: false.obs,
  );

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController primaryAddressController = TextEditingController();
  TextEditingController secundaryAddressController = TextEditingController();
  TextEditingController subscribedController = TextEditingController();

  final editor = false.obs;

  final logger = Logger(
    printer: PrettyPrinter(),
  );

  bool setView() {
    firstNameController.text = user.firstName!.value;
    lastNameController.text = user.lastName!.value;
    emailController.text = user.email!.value;
    primaryAddressController.text = user.primaryAddress!.value;
    secundaryAddressController.text = user.secundaryAddress!.value;
    subscribedController.text = user.suscribed!.value ? "Premium" : "Basic";
    return true;
  }

  Future getUserInfo() async {
    final ctrl = Get.find<SessionController>();
    dio.Response response;
    try {
      response = await ProfileProvider()
          .getUserInfo(token: ctrl.token.value, uid: ctrl.userId.value);
      if (response.statusCode == 200) {
        logger.i(response.data);
        setUserFromJson(response.data as Map<String, dynamic>);
        setView();
      } else {
        logger.i(response.statusCode);
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  bool setUserFromJson(Map<String, dynamic> json) {
    user.firstName!.value = json['firstName'] as String;
    user.lastName!.value = json['lastName'] as String;
    user.email!.value = json['email'] as String;

    user.primaryAddress!.value = json['primaryAddress'] as String;

    user.secundaryAddress!.value = json['secundaryAddress'] as String;

    user.locationCode!.value = json['locationCode'] as String;
    user.locationDescription!.value = json['locationDescription'] as String;
    user.suscribed!.value = json['suscribed'] as bool;
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
