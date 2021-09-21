import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/steps_item.dart';
import 'package:re_quirement/app/utils/widgets/custom_form_field.dart';
import 'package:re_quirement/app/utils/widgets/tag_item.dart';

class Step3 extends GetView<ProjectsController> {
  const Step3({
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
            ? screenSize.height * 3.3 / 6
            : screenSize.height * 2.3 / 6,
        constraints: BoxConstraints(
            minHeight: screenSize.width < 950 ? 330 : 230, maxHeight: 500),
        child: Form(
          key: controller.projectsStep2FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                width: 700,
              ),
              StepsItem(
                itemLabel: "Agregar Tag",
                withBorder: false,
                child: SizedBox(
                  width: screenSize.width * 3 / 14,
                  // padding: const EdgeInsets.only(left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CustomFormField(
                          controller: controller.tagNameController,
                          inputValidation: controller.validateTagName,
                          inputType: TextInputType.text,
                          icon: Icons.local_offer_outlined,
                          hintText: 'Ingresa un tag',
                          labelText: '',
                          inputValue: controller.tagName,
                          inputSetter: (String value) {
                            controller.tagName = value;
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (controller.validTag()) {
                            controller.newTag();
                          }
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  ),
                ),
              ),
              Obx(
                () => Wrap(
                  spacing: 10,
                  children: controller.tags.map(
                    (e) {
                      return TagItem(
                        tag: e["tagDescription"].toString(),
                      );
                    },
                  ).toList(),
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
                      controller.step.value = 1;
                      Get.back();
                    },
                    style: OutlinedButton.styleFrom(
                      primary: Colors.red,
                      //side: const BorderSide(color: Colors.red),
                    ),
                    child: const Text("Cancel"),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (controller.autoGenerate.value) {
                        controller.step.value = 2;
                      } else {
                        controller.step.value = 1;
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange),
                    ),
                    child: const Text("Back"),
                  ),
                  const Expanded(
                    child: SizedBox(
                      width: 1,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (controller.tags.isNotEmpty) {
                        await controller.createProject();
                      }
                    },
                    child: const Text("Finalizar"),
                  ),
                  const Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 1,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
