import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:re_quirement/app/modules/login/controllers/login_controller.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/controllers/navbar_controller.dart';

void main() {
  Get.put(SessionController());
  Get.put(NavbarController());
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(ProjectsController());
  Get.put(MyProjectDetailsController());
  runApp(
    GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
