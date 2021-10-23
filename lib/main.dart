import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:re_quirement/app/modules/login/controllers/login_controller.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/utils/controllers/session_controller.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/profile/controllers/profile_controller.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/constants/styles.dart';
import 'app/utils/controllers/navbar_controller.dart';

void main() {
  final ThemeData theme = ThemeData(fontFamily: 'Montserrat');

  Get.put(SessionController());
  Get.put(NavbarController());
  Get.put(LoginController());
  Get.put(HomeController());
  Get.put(ProjectsController());
  Get.put(ProfileController());
  Get.put(MyProjectDetailsController());
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
      title: "ReQuirement",
      // onGenerateTitle: (BuildContext context) =>
      //     AppLocalizations.of(context)!.loginTitle,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: active,
        ),
      ),
    ),
  );
}
