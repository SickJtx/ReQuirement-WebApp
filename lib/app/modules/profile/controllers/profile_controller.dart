import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:re_quirement/app/modules/profile/providers/profile_provider.dart';
import 'package:re_quirement/app/modules/profile/user_profile_model.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

class ProfileController extends GetxController {
  Rx<UserProfile> user = UserProfile(
    email: "empty".obs,
    firstName: "empty".obs,
    lastName: "empty".obs,
    locationCode: "empty".obs,
    locationDescription: "empty".obs,
    primaryAddress: "empty".obs,
    secundaryAddress: "empty".obs,
    suscribed: false.obs,
  ).obs;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController primaryAddressController = TextEditingController();
  TextEditingController secundaryAddressController = TextEditingController();
  TextEditingController subscribedController = TextEditingController();

  final RxBool editor = false.obs;
  final RxBool loading = true.obs;
  final data = {}.obs;
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  void setView() {
    firstNameController.text = user.value.firstName!.value;
    lastNameController.text = user.value.lastName!.value;
    emailController.text = user.value.email!.value;
    primaryAddressController.text = user.value.primaryAddress!.value;
    secundaryAddressController.text = user.value.secundaryAddress!.value;
    subscribedController.text =
        user.value.suscribed!.value ? "Premium" : "Basic";
  }

  Future getUserInfo() async {
    final ctrl = Get.find<SessionController>();
    loading.value = true;
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
      loading.value = false;
    } on Exception catch (e) {
      loading.value = false;
      logger.e(e);
    }
  }

  bool setUserFromJson(Map<String, dynamic> json) {
    user.value.firstName!.value = json['firstName'] as String;
    user.value.lastName!.value = json['lastName'] as String;
    user.value.email!.value = json['email'] as String;

    user.value.primaryAddress!.value = json['primaryAddress'] as String;

    user.value.secundaryAddress!.value = json['secundaryAddress'] as String;

    user.value.locationCode!.value = json['locationCode'] as String;
    user.value.locationDescription!.value =
        json['locationDescription'] as String;
    user.value.suscribed!.value = json['suscribed'] as bool;

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
