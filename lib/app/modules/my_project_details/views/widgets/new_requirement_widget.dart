import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';
import 'package:re_quirement/app/modules/my_project_details/views/widgets/requirement_input.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/steps_item.dart';
import 'package:re_quirement/app/utils/widgets/labeled_item.dart';

class NewRequirementWidget extends GetView<MyProjectDetailsController> {
  const NewRequirementWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    controller.cleanControllers();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        child: Container(
          width: screenSize.width * 2.5 / 7,
          height: screenSize.height * 3.4 / 6,
          constraints: BoxConstraints(
              minHeight: screenSize.width < 950 ? 330 : 230, maxHeight: 500),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          //height: screenSize.height * 3 / 5,
          child: ListView(
            children: [
              Center(
                child: RequirementInput(
                  withBorder: false,
                  itemLabel: AppLocalizations.of(context)!.asA,
                  child: TextFormField(
                    controller: controller.actorController,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: RequirementInput(
                  withBorder: false,
                  itemLabel: AppLocalizations.of(context)!.iWant,
                  child: TextFormField(controller: controller.actionController),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: RequirementInput(
                  withBorder: false,
                  itemLabel: AppLocalizations.of(context)!.soThat,
                  child: TextFormField(
                      controller: controller.descriptionController),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: RequirementInput(
                  withBorder: false,
                  itemLabel: AppLocalizations.of(context)!.typeDetailsProject,
                  child: Obx(
                    () => SizedBox(
                      child: Center(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            elevation: 16,
                            value: controller.projectType.value,
                            items: ["FUNCTIONAL", "NON FUNCTIONAL"].map(
                              (value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              controller.projectType.value = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                      await controller.createRequirements();
                      await controller.getProjectInfo(
                          pid: controller.projectInfo["id"].toString());
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                    child: const Text(
                      "Crear Requisito",
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
