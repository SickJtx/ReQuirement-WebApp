import 'package:get/get.dart';

import 'package:re_quirement/app/modules/home/bindings/home_binding.dart';
import 'package:re_quirement/app/modules/home/views/home_view.dart';
import 'package:re_quirement/app/modules/login/bindings/login_binding.dart';
import 'package:re_quirement/app/modules/login/views/login_view.dart';
import 'package:re_quirement/app/modules/my_project_details/bindings/my_project_details_binding.dart';
import 'package:re_quirement/app/modules/my_project_details/views/my_project_details_view.dart';
import 'package:re_quirement/app/modules/profile/bindings/profile_binding.dart';
import 'package:re_quirement/app/modules/profile/views/profile_view.dart';
import 'package:re_quirement/app/modules/projects/bindings/projects_binding.dart';
import 'package:re_quirement/app/modules/projects/views/projects_view.dart';
import 'package:re_quirement/app/modules/signup/bindings/signup_binding.dart';
import 'package:re_quirement/app/modules/signup/views/signup_view.dart';
import 'package:re_quirement/app/modules/team/bindings/team_binding.dart';
import 'package:re_quirement/app/modules/team/views/team_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const String INITIAL = Routes.LOGIN;

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
      page: () => SignUpView(),
      binding: SignUpBinding(),
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
        children: [
          GetPage(
            name: _Paths.MY_PROJECT_DETAILS,
            page: () => MyProjectDetailsView(),
            binding: MyProjectDetailsBinding(),
          ),
        ]),
  ];
}
