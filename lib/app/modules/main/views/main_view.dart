import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:re_quirement/app/modules/home/views/home_view.dart';
import 'package:re_quirement/app/modules/login/views/login_view.dart';
import 'package:re_quirement/app/modules/profile/views/profile_view.dart';
import 'package:re_quirement/app/modules/projects/views/projects_view.dart';
import 'package:re_quirement/app/modules/signup/views/signup_view.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';


class MainView extends GetView<NavbarController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        switch (controller.currentIndex.value) {
          case 0:
            return SignUpView();

          case 1:
            return LoginView();

          case 2:
            return HomeView();

          case 3:
            return ProjectsView();

          case 4:
            return ProfileView();
          default:
            return const SizedBox();
        }
      },
    );
  }
}
