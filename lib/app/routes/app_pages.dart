import 'package:get/get.dart';

import 'package:re_quirement/app/modules/home/bindings/home_binding.dart';
import 'package:re_quirement/app/modules/home/views/home_view.dart';
import 'package:re_quirement/app/modules/login/bindings/login_binding.dart';
import 'package:re_quirement/app/modules/login/views/login_view.dart';
import 'package:re_quirement/app/modules/profile/bindings/profile_binding.dart';
import 'package:re_quirement/app/modules/profile/views/profile_view.dart';
import 'package:re_quirement/app/modules/projects/bindings/projects_binding.dart';
import 'package:re_quirement/app/modules/projects/views/projects_view.dart';
import 'package:re_quirement/app/modules/signin/bindings/signin_binding.dart';
import 'package:re_quirement/app/modules/signin/views/signin_view.dart';
import 'package:re_quirement/app/modules/team/bindings/team_binding.dart';
import 'package:re_quirement/app/modules/team/views/team_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SINGIN,
      page: () => SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.TEAM,
      page: () => TeamView(),
      binding: TeamBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PROJECTS,
      page: () => ProjectsView(),
      binding: ProjectsBinding(),
    ),
  ];
}
