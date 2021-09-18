import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';

import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                            child: Column(
                              children: [
                                const Expanded(
                                  child: SizedBox(
                                    height: 30,
                                  ),
                                ),
                                Text(
                                  "Inicio de sesión",
                                  style: GoogleFonts.roboto(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Expanded(
                                  child: SizedBox(
                                    height: 50,
                                  ),
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 300),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.1),
                                          offset: const Offset(0, 40),
                                          blurRadius: 80),
                                    ],
                                  ),
                                  child: Container(
                                    width: screenSize.width / 4,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextField(
                                      controller: controller.usernameController,
                                      decoration: const InputDecoration(
                                        icon: Icon(Icons.email_outlined),
                                        hintText: "Ingresa tu correo",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  constraints:
                                      const BoxConstraints(minWidth: 300),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black54),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(.1),
                                          offset: const Offset(0, 40),
                                          blurRadius: 80),
                                    ],
                                  ),
                                  child: Container(
                                    width: screenSize.width / 4,
                                    padding: const EdgeInsets.only(left: 8),
                                    child: TextField(
                                      controller: controller.passwordController,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        icon: Icon(CupertinoIcons.padlock),
                                        hintText: "Ingresa tu contraseña",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
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
                                              ? Icons.toggle_on_outlined
                                              : Icons.toggle_off_outlined,
                                          color: controller.keepOnline.value
                                              ? Colors.green
                                              : Colors.black54,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          "Mantener sesión iniciada",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: controller.keepOnline.value
                                                ? Colors.green
                                                : Colors.black54,
                                          ),
                                        )
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
                                      controller.getSesion();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.green),
                                    ),
                                    child: Text(
                                      "INGRESAR",
                                      style: GoogleFonts.roboto(
                                        fontSize: 20,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w300,
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
                                      "Recuperar contraseña",
                                      style: GoogleFonts.roboto(
                                          decoration: TextDecoration.underline,
                                          color: controller.hoverText.value
                                              ? Colors.lightBlue[200]
                                              : Colors.black54),
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
