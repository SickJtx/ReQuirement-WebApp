import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

class AppBarItem extends GetView<NavbarController> {
  const AppBarItem({
    Key? key,
    required this.route,
    required this.title,
    required this.index,
  }) : super(key: key);

  final String? route;
  final String? title;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onHover: (value) {
          value
              ? controller.hovers[index!] = true
              : controller.hovers[index!] = false;
        },
        onTap: () async {
          await controller.changePage(index!);
        },
        hoverColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              title!,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: controller.hovers[index!]
                    ? active
                    : controller.viewFlags[index!]
                        ? active
                        : disable,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextDot(visible: controller.hovers[index!]),
          ],
        ),
      ),
    );
  }
}

class TextDot extends StatelessWidget {
  const TextDot({
    Key? key,
    required this.visible,
  }) : super(key: key);

  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainAnimation: true,
      maintainState: true,
      maintainSize: true,
      child: Container(
        height: 7,
        width: 7,
        decoration: BoxDecoration(
            color: active, borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
