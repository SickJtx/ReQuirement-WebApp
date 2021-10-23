import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';

class RequirementCloneWidget extends GetView<MyProjectDetailsController> {
  const RequirementCloneWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        width: screenSize.width * 4 / 7,
        height: screenSize.width < 950
            ? screenSize.height * 3.6 / 6
            : screenSize.height * 2.6 / 6,
        constraints: BoxConstraints(
            minHeight: screenSize.width < 950 ? 330 : 230, maxHeight: 500),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        //height: screenSize.height * 3 / 5,
        child: Obx(
          () => controller.dropdownItems().length == 1
              ? SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                          child: SizedBox(
                        height: 1,
                      )),
                      Text(
                          "No hay proyectos a donde clonar. \nPor favor vuelva a intentarlo luego de crear uno nuevo",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center),
                      const Expanded(
                          child: SizedBox(
                        height: 1,
                      )),
                      ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green),
                        ),
                        child: const Text(
                          "Aceptar",
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: AppLocalizations.of(context)!
                                  .selectRequirementStep2,
                              style: DefaultTextStyle.of(context).style,
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${controller.qSelectedItems.value} ',
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!
                                      .selectedStep2,
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(
                              width: 1,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            height: 30,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                elevation: 16,
                                value: controller.selectedProjectName.value,
                                items: (controller.dropdownItems()).map(
                                  (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  },
                                ).toList(),
                                onChanged: (String? value) {
                                  controller.selectedProjectName.value = value!;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.requirementList.value.length,
                        itemBuilder: (context, index) {
                          final dynamic map =
                              controller.requirementList.value[index];
                          return Obx(
                            () => Container(
                              color: controller.isSelected.value[index].value
                                  ? const Color(0xFFD6D6D6)
                                  : Colors.transparent,
                              child: ListTile(
                                leading: controller
                                        .isSelected.value[index].value
                                    ? const Icon(Icons.check_circle)
                                    : const Icon(Icons.check_circle_outline),
                                title: Text(
                                    toBeginningOfSentenceCase(
                                        map["actionDescription"].toString())!,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400)),
                                selected:
                                    controller.isSelected.value[index].value,
                                onTap: () {
                                  // ignore: invalid_use_of_protected_member
                                  if (!controller
                                      .isSelected.value[index].value) {
                                    // ignore: invalid_use_of_protected_member
                                    controller.selectedRequirements.value
                                        .add(index);
                                    controller.isSelected.value[index].value =
                                        true;
                                    controller.qSelectedItems.value++;
                                  } else {
                                    // ignore: invalid_use_of_protected_member
                                    controller.selectedRequirements.value
                                        .remove(index);
                                    controller.isSelected.value[index].value =
                                        false;
                                    controller.qSelectedItems.value--;
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            Get.back();
                            controller.clearList();
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.red,
                            //side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text(
                            "Cancelar",
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (controller.qSelectedItems > 0 &&
                                controller.selectedProjectName.value !=
                                    "Seleccionar proyecto") {
                              await controller.cloneRequirements();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: const Text(
                            "Reutilizar",
                          ),
                        ),
                        const Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
