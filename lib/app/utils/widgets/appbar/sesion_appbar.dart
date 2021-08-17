import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'appbar_item.dart';

class SesionAppBar extends GetView<NavbarController> {
  const SesionAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: screenSize.width / 8,
        ),
        AppBarItem(
          index: 2,
          route: '/home',
          title: "Inicio",
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 3,
          route: '/projects',
          title: "Mis Proyectos",
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 4,
          route: '/team',
          title: "Equipo de Trabajo",
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 5,
          route: '/profile',
          title: "Perfil",
        ),
        SizedBox(
          width: screenSize.width / 20,
        )
      ],
    );
  }
}
