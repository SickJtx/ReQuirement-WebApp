import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          child: Center(
            child: Column(
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
                            AppLocalizations.of(context)!.createAccountProfile,
                            style: GoogleFonts.montserrat(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Wrap(
                            children: [
                              ProfileItem(
                                itemLabel: AppLocalizations.of(context)!
                                    .firstNameProfile,
                                controller: controller.firstNameController,
                                editor: controller.editor.value,
                              ),
                              ProfileItem(
                                itemLabel: AppLocalizations.of(context)!
                                    .lastNameProfile,
                                controller: controller.lastNameController,
                                editor: controller.editor.value,
                              ),
                            ],
                          ),
                          ProfileItem(
                            itemLabel:
                                AppLocalizations.of(context)!.emailProfile,
                            controller: controller.emailController,
                            editor: controller.editor.value,
                          ),
                          Wrap(
                            children: [
                              ProfileItem(
                                itemLabel: AppLocalizations.of(context)!
                                    .address1Profile,
                                controller: controller.primaryAddressController,
                                editor: controller.editor.value,
                              ),
                              ProfileItem(
                                itemLabel: AppLocalizations.of(context)!
                                    .address2Profile,
                                controller:
                                    controller.secundaryAddressController,
                                editor: controller.editor.value,
                              ),
                            ],
                          ),
                          ProfileItem(
                            itemLabel:
                                AppLocalizations.of(context)!.typeOfPlanProfile,
                            controller: controller.subscribedController,
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
                                    MaterialStateProperty.all(Colors.green),
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
            ),
          ),
        ),
      ),
    );
  }
}
