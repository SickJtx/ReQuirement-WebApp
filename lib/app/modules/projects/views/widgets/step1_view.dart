import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/steps_item.dart';

class Step1 extends GetView<ProjectsController> {
  const Step1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width * 4 / 7,
      height: screenSize.width < 950
          ? screenSize.height * 3 / 6
          : screenSize.height * 2 / 6,
      constraints: BoxConstraints(
          minHeight: screenSize.width < 950 ? 330 : 230, maxHeight: 500),
      //height: screenSize.height * 3 / 5,
      child: Column(
        children: [
          Wrap(
            children: [
              StepsItem(
                itemLabel: "Nombre del proyecto",
                child: Container(
                  width: screenSize.width * 3 / 14,
                  padding: const EdgeInsets.only(left: 8),
                  child: TextField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    controller: controller.projectNameController,
                  ),
                ),
              ),
              StepsItem(
                itemLabel: "Tipo de mercado",
                child: Obx(
                  () => SizedBox(
                    width: screenSize.width * 3 / 14,
                    child: Center(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          elevation: 16,
                          value: controller.tipoMercado.value,
                          items: controller.dropdownItems().map(
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
            itemLabel: "Visibilidad del proyecto",
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
                  controller.step.value = 2;
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: const Text("NEXT"),
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
    );
  }
}
