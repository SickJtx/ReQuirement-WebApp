import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/profile_controller.dart';
import 'widgets/profile_item.dart';

class ProfileView extends GetView<ProfileController> {
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
        body: SingleChildScrollView(
          child: Obx(
            () {
              return controller.loading.value
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
                  : Column(
                      children: [
                        Container(
                          constraints: BoxConstraints(
                              minHeight: screenSize.height * 8.5 / 10,
                              minWidth: screenSize.width * 9 / 10),
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          color: Colors.white,
                          child: Obx(
                            () {
                              return Column(
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!
                                        .createAccountProfile,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Wrap(
                                    children: [
                                      Obx(() => ProfileItem(
                                            itemLabel:
                                                AppLocalizations.of(context)!
                                                    .firstNameProfile,
                                            infoLabel: controller
                                                .user.value.firstName!.value,
                                            textController:
                                                controller.firstNameController,
                                            editor: controller.editor.value,
                                            onChange: (String value) {
                                              controller.user.value.firstName!
                                                      .value =
                                                  controller
                                                      .firstNameController.text;
                                            },
                                          )),
                                      ProfileItem(
                                        itemLabel: AppLocalizations.of(context)!
                                            .lastNameProfile,
                                        infoLabel: controller
                                            .user.value.lastName!.value,
                                        textController:
                                            controller.lastNameController,
                                        editor: controller.editor.value,
                                        onChange: (String value) {
                                          controller
                                                  .user.value.lastName!.value =
                                              controller
                                                  .lastNameController.text;
                                        },
                                      ),
                                    ],
                                  ),
                                  ProfileItem(
                                    itemLabel: AppLocalizations.of(context)!
                                        .emailProfile,
                                    infoLabel:
                                        controller.user.value.email!.value,
                                    textController: controller.emailController,
                                    editor: controller.editor.value,
                                    onChange: (String value) {
                                      controller.user.value.email!.value =
                                          controller.emailController.text;
                                    },
                                  ),
                                  Wrap(
                                    children: [
                                      ProfileItem(
                                        itemLabel: AppLocalizations.of(context)!
                                            .address1Profile,
                                        infoLabel: controller
                                            .user.value.primaryAddress!.value,
                                        textController:
                                            controller.primaryAddressController,
                                        editor: controller.editor.value,
                                        onChange: (String value) {
                                          controller.user.value.primaryAddress!
                                                  .value =
                                              controller
                                                  .primaryAddressController
                                                  .text;
                                        },
                                      ),
                                      ProfileItem(
                                        itemLabel: AppLocalizations.of(context)!
                                            .address2Profile,
                                        infoLabel: controller
                                            .user.value.secundaryAddress!.value,
                                        textController: controller
                                            .secundaryAddressController,
                                        editor: controller.editor.value,
                                        onChange: (String value) {
                                          controller.user.value
                                                  .secundaryAddress!.value =
                                              controller
                                                  .secundaryAddressController
                                                  .text;
                                        },
                                      ),
                                    ],
                                  ),
                                  ProfileItem(
                                    itemLabel: AppLocalizations.of(context)!
                                        .typeOfPlanProfile,
                                    infoLabel:
                                        controller.user.value.suscribed!.value
                                            ? "Free user"
                                            : "Premium user",
                                    textController:
                                        controller.subscribedController,
                                    onChange: (String value) {},
                                    editor: false,
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 200,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.editor.value =
                                            !controller.editor.value;
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .editProfileProfile,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 20,
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
