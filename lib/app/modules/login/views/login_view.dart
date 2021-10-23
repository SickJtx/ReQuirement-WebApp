import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';
import 'package:re_quirement/app/utils/widgets/custom_form_field.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    Get.find<NavbarController>().showCurrent();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: const DesktopNavbar(),
        ),
        body: Obx(
          () => controller.loading.value
              ? Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: LoadingIndicator(
                      colors: [Colors.deepOrange.shade500],
                      indicatorType: Indicator.ballClipRotateMultiple,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height / 15,
                          ),
                          Container(
                            width: screenSize.width / 3,
                            height: screenSize.height * 3 / 4,
                            padding: const EdgeInsets.all(20),
                            constraints: const BoxConstraints(
                                minWidth: 400, maxWidth: 500, minHeight: 450),
                            color: Colors.white,
                            child: Form(
                              key: controller.loginFormKey,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  const Expanded(
                                    child: SizedBox(
                                      height: 30,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.loginTitle,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 40,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      height: 50,
                                    ),
                                  ),
                                  CustomFormField(
                                    controller: controller.usernameController,
                                    inputValidation: controller.validateEmail,
                                    inputType: TextInputType.emailAddress,
                                    icon: Icons.email_outlined,
                                    hintText:
                                        AppLocalizations.of(context)!.mailHint,
                                    labelText:
                                        AppLocalizations.of(context)!.mailLabel,
                                    inputValue: controller.username,
                                    inputSetter: (String value) {
                                      controller.username = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  CustomFormField(
                                    obscure: true,
                                    controller: controller.passwordController,
                                    inputValidation:
                                        controller.validatePassword,
                                    inputType: TextInputType.visiblePassword,
                                    icon: Icons.lock_outline,
                                    hintText: AppLocalizations.of(context)!
                                        .passwordHint,
                                    labelText: AppLocalizations.of(context)!
                                        .passwordLabel,
                                    inputValue: controller.password,
                                    inputSetter: (String value) {
                                      controller.password = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Obx(
                                    () => InkWell(
                                      onTap: () {
                                        controller.keepOnline.value =
                                            !controller.keepOnline.value;
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            controller.keepOnline.value
                                                ? Icons.check_box_outlined
                                                : Icons
                                                    .check_box_outline_blank_outlined,
                                            color: controller.keepOnline.value
                                                ? active
                                                : lightGrayText,
                                            size: 20,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .keepSessionOn,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300,
                                              color: controller.keepOnline.value
                                                  ? active
                                                  : lightGrayText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        //controller.getUserId();
                                        if (controller.checkLogin()) {
                                          controller.getSesion();
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          active,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              13.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .loginButtonText,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Obx(
                                    () => InkWell(
                                      onTap: () {},
                                      onHover: (value) {
                                        controller.hoverText.value = value;
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .retrievePassword,
                                        style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          color: controller.hoverText.value
                                              ? active.withOpacity(.7)
                                              : active,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Expanded(
                                    child: SizedBox(
                                      height: 20,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
