import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'login_appbar.dart';
import 'sesion_appbar.dart';

class DesktopNavbar extends GetView<NavbarController> {
  const DesktopNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50),
        height: screenSize.height / 12,
        //padding: EdgeInsets.all(screenSize.height / 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            Text(
              'ReQuirement',
              style: GoogleFonts.montserrat(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Obx(
              () => Expanded(
                child: controller.onSesion.value
                    ? const SesionAppBar()
                    : const LoginAppBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
