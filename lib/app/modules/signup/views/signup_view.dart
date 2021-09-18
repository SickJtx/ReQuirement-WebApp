import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/signup_controller.dart';
import 'widgets/singin_item.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                            width: screenSize.width * 5 / 7,
                            height: screenSize.width < 815
                                ? 800
                                : screenSize.height < 680
                                    ? 550
                                    : screenSize.height * 3 / 4,
                            padding: const EdgeInsets.all(20),
                            color: Colors.white,
                            //constraints: BoxConstraints(minHeight: 900),
                            child: Column(
                              children: [
                                Text(
                                  "Crear Cuenta",
                                  style: GoogleFonts.roboto(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                Wrap(
                                  children: [
                                    SigninItem(
                                      itemLabel: "Nombre",
                                      textController:
                                          controller.firstNameController,
                                    ),
                                    SigninItem(
                                      itemLabel: "Apellido",
                                      textController:
                                          controller.lastNameController,
                                    ),
                                  ],
                                ),
                                SigninItem(
                                  itemLabel: "Correo",
                                  textController: controller.usernameController,
                                ),
                                Wrap(
                                  children: [
                                    SigninItem(
                                      itemLabel: "Contraseña",
                                      textController:
                                          controller.passwordController,
                                      obscure: true,
                                    ),
                                    SigninItem(
                                      itemLabel: "Repetir Contraseña",
                                      textController:
                                          controller.repeatPasswordController,
                                      obscure: true,
                                    ),
                                  ],
                                ),
                                Wrap(
                                  children: [
                                    SigninItem(
                                      itemLabel: "Dirección 1",
                                      textController:
                                          controller.primaryAddressController,
                                    ),
                                    SigninItem(
                                      itemLabel: "Dirección 2",
                                      textController:
                                          controller.secundaryAddressController,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                SizedBox(
                                  height: 40,
                                  width: 200,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      await controller.signUpUser();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    child: Text(
                                      "REGISTRAR",
                                      style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ],
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
