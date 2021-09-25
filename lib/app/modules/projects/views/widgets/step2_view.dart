import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:re_quirement/app/modules/projects/controllers/projects_controller.dart';

class Step2 extends GetView<ProjectsController> {
  const Step2({
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
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        //height: screenSize.height * 3 / 5,
        child: Obx(
          () => controller.generatorLoading.value
              ? Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: LoadingIndicator(
                      colors: [Colors.deepOrange.shade500],
                      indicatorType: Indicator.ballClipRotateMultiple,
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => RichText(
                        text: TextSpan(
                          text: AppLocalizations.of(context)!
                              .selectRequirementStep2,
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: '${controller.qSelectedItems.value} ',
                            ),
                            TextSpan(
                              text: AppLocalizations.of(context)!.selectedStep2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            controller.generatedRequirements.value.length,
                        itemBuilder: (context, index) {
                          final dynamic map =
                              controller.generatedRequirements[index];
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
                                        map["systemDescription"].toString())!,
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
                          },
                          style: OutlinedButton.styleFrom(
                            primary: Colors.red,
                            //side: const BorderSide(color: Colors.red),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancelLabelStep2,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            controller.step.value = 1;
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.backLabelStep2,
                          ),
                        ),
                        const Expanded(
                          child: SizedBox(
                            width: 1,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (controller.selectedRequirements.isNotEmpty) {
                              controller.step.value = 3;
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.nextLabelStep2,
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
