import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'appbar_item.dart';

class SesionAppBar extends GetView<NavbarController> {
  const SesionAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: screenSize.width / 8,
        ),
        AppBarItem(
          index: 2,
          route: '/home',
          title: AppLocalizations.of(context)!.homeAppbarText,
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 3,
          route: '/projects',
          title: AppLocalizations.of(context)!.projectsAppbarText,
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 4,
          route: '/profile',
          title: AppLocalizations.of(context)!.profileAppbarText,
        ),
        SizedBox(
          width: screenSize.width / 20,
        )
      ],
    );
  }
}
