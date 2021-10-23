import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'appbar_item.dart';

class LoginAppBar extends GetView<NavbarController> {
  const LoginAppBar({
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
          index: 0,
          route: '/signin',
          title: AppLocalizations.of(context)!.signInAppbarText,
        ),
        SizedBox(
          width: screenSize.width / 20,
        ),
        AppBarItem(
          index: 1,
          route: '/login',
          title: AppLocalizations.of(context)!.logInAppbarText,
        ),
        SizedBox(
          width: screenSize.width / 20,
        )
      ],
    );
  }
}
