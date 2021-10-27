import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/steps_item.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/widgets/custom_form_field.dart';

class Step1 extends GetView<ProjectsController> {
  const Step1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
        width: screenSize.width * 4 / 7,
        height: screenSize.width < 950
            ? screenSize.height * 3.6 / 6
            : screenSize.height * 2.6 / 6,
        constraints: BoxConstraints(
            minHeight: screenSize.width < 950 ? 330 : 230, maxHeight: 500),
        //height: screenSize.height * 3 / 5,
        child: Form(
          key: controller.projectsStep1FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                children: [
                  StepsItem(
                    itemLabel: AppLocalizations.of(context)!.nameOfProjectStep1,
                    withBorder: false,
                    child: SizedBox(
                      width: screenSize.width * 3 / 14,
                      child: CustomFormField(
                        controller: controller.projectNameController,
                        inputValidation: controller.validateProjectName,
                        inputType: TextInputType.text,
                        icon: Icons.business_center_outlined,
                        hintText: AppLocalizations.of(context)!
                            .nameOfProjectHintStep1,
                        labelText: AppLocalizations.of(context)!
                            .nameOfProjectLabelStep1,
                        inputValue: controller.projectName,
                        inputSetter: (String value) {
                          controller.projectName = value;
                        },
                      ),
                    ),
                  ),
                  StepsItem(
                    itemLabel:
                        AppLocalizations.of(context)!.typeOfMarketLabelStep1,
                    child: Obx(
                      () => SizedBox(
                        width: screenSize.width * 3 / 14,
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              isExpanded: true,
                              elevation: 16,
                              value: controller.tipoMercado.value,
                              items: (controller.dropdownItems()).map(
                                (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (String? value) {
                                controller.tipoMercado.value = value!;
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              StepsItem(
                itemLabel: AppLocalizations.of(context)!.visibilityLabelStep1,
                child: Obx(
                  () => SizedBox(
                    width: screenSize.width * 3 / 14,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          elevation: 16,
                          value: controller.visibilidadProyecto.value,
                          items: const ["Público", "Privado"].map(
                            (value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String? value) {
                            controller.visibilidadProyecto.value = value!;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: active,
                        value: controller.autoGenerate.value,
                        onChanged: (bool? value) {
                          controller.autoGenerate.value = value!;
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.tipoMercado.value = "Seleccionar tipo";
                          controller.autoGenerate.value =
                              !controller.autoGenerate.value;
                        },
                        child: Text(
                          AppLocalizations.of(context)!.autoGenerateStep1,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                  child: SizedBox(
                height: 1,
              )),
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
                      controller.clearForms();
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red,
                      //side: const BorderSide(color: Colors.red),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.cancelLabelStep1,
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.validStep1() &&
                          controller.tipoMercado.value !=
                              AppLocalizations.of(context)!.selectTypeStep1) {
                        if (controller.autoGenerate.value) {
                          controller.step.value = 2;
                          await controller.generateRequirements();
                        } else {
                          controller.step.value = 3;
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.nextLabelStep1,
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
