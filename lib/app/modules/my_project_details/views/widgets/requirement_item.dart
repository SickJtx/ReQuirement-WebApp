import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';

class RequirementItem extends GetView<MyProjectDetailsController> {
  const RequirementItem({
    Key? key,
    required this.requirement,
  }) : super(key: key);
  final Rx<Requirement> requirement;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    void _openDialog() {
      controller.setControllers(value: requirement.value);
      Get.defaultDialog(
        title: AppLocalizations.of(context)!.detailDetailsProject,
        titleStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        content: GestureDetector(
          onTap: () {
            controller.cleanEditables();
          },
          child: SizedBox(
            width: screenSize.width * 1 / 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      children: [
                        const WidgetSpan(
                          child: Icon(Icons.person_outline),
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.asA,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenSize.width * 1.8 / 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          controller.cleanEditables();
                          controller.startEditing(
                            index: 0,
                          );
                        },
                        child: Obx(
                          () => controller.isEditing[0].value
                              ? Column(
                                  children: [
                                    TextFormField(
                                      controller: controller.actorController,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                            controller.editRequirements(
                                                requirement.value.id!);
                                          },
                                          child: const Text("Save"),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                          },
                                          icon: const Icon(Icons.close),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 40,
                                  child: Text(
                                    controller.actorController.text,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      children: [
                        const WidgetSpan(
                          child: Icon(Icons.article_outlined),
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.iWant,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenSize.width * 1.8 / 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          controller.cleanEditables();
                          controller.startEditing(
                            index: 1,
                          );
                        },
                        child: Obx(
                          () => controller.isEditing[1].value
                              ? Column(
                                  children: [
                                    TextFormField(
                                      controller: controller.actionController,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                            controller.editRequirements(
                                                requirement.value.id!);
                                          },
                                          child: const Text("Save"),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                          },
                                          icon: const Icon(Icons.close),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 40,
                                  child: Text(
                                    controller.actionController.text,
                                    style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      children: [
                        const WidgetSpan(
                          child: Icon(Icons.assistant_photo_outlined),
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text: AppLocalizations.of(context)!.soThat,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: screenSize.width * 1.8 / 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: InkWell(
                        onHover: (value) {},
                        onTap: () {
                          controller.cleanEditables();
                          controller.startEditing(
                            index: 2,
                          );
                        },
                        child: Obx(
                          () => controller.isEditing[2].value
                              ? Column(
                                  children: [
                                    TextFormField(
                                      controller:
                                          controller.descriptionController,
                                    ),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                            controller.editRequirements(
                                                requirement.value.id!);
                                          },
                                          child: const Text("Save"),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            controller.cleanEditables();
                                          },
                                          icon: const Icon(Icons.close),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              : Text(
                                  controller.descriptionController.text,
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w400),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                      children: [
                        const WidgetSpan(
                          child: Icon(Icons.clear_all_rounded),
                        ),
                        const TextSpan(
                          text: " ",
                        ),
                        TextSpan(
                          text:
                              AppLocalizations.of(context)!.typeDetailsProject,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 40,
                    child: Text(
                      requirement.value.type!,
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        controller.cleanEditables();
      },
      child: Container(
        width: screenSize.width * 2.7 / 10,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 10),
        constraints: const BoxConstraints(minWidth: 250),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(color: Colors.black54),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                offset: const Offset(0, 40),
                blurRadius: 80),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 13,
                  width: 13,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(requirement.value.codigo!),
                const Expanded(
                  child: SizedBox(
                    width: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.cleanEditables();
                    _openDialog();
                  },
                  icon: const Icon(
                    Icons.visibility_outlined,
                    size: 20,
                    color: Colors.black45,
                  ),
                )
              ],
            ),
            const Divider(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      width: 100,
                      height: 30,
                      child: Text(requirement.value.detalles!)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(requirement.value.prioridad!)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
