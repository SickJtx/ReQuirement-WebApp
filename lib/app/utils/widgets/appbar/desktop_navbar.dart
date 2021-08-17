import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'login_appbar.dart';
import 'sesion_appbar.dart';

class DesktopNavbar extends GetView<NavbarController> {
  DesktopNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size(screenSize.width, 1000),
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        height: screenSize.height / 12,
        color: Colors.black.withAlpha(200),
        //padding: EdgeInsets.all(screenSize.height / 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 20),
            Text(
              "Re-Quirement",
              style: GoogleFonts.tradeWinds(fontSize: 20, color: Colors.white),
            ),
            Obx(
              () => Expanded(
                child:
                    controller.onSesion.value ? SesionAppBar() : LoginAppBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
