import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';
import 'package:re_quirement/app/utils/widgets/labeled_item.dart';
import 'package:re_quirement/app/utils/widgets/tag_item.dart';

import '../controllers/my_project_details_controller.dart';
import 'widgets/requirement_item.dart';

class MyProjectDetailsView extends GetView<MyProjectDetailsController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: const DesktopNavbar(),
      ),
      body: Obx(
        () => controller.loading.value
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
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: screenSize.width * 9 / 10,
                        constraints: BoxConstraints(
                          minHeight: screenSize.height * 8.5 / 10,
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              controller.projectName.value,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: [
                                LabeledItem(
                                  itemLabel: "Tipo de mercado:",
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.projectMarketTypeName.value,
                                    ),
                                  ),
                                ),
                                LabeledItem(
                                  itemLabel: "Visibilidad:",
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      controller.visibility.value,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Tags del proyecto",
                                style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Obx(
                              () => controller.tags.value.isEmpty
                                  ? const SizedBox()
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        spacing: 10,
                                        children: (controller.tags.value).map(
                                          (e) {
                                            return TagItem(
                                              tag: e["tagDescription"]
                                                  .toString(),
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              width: screenSize.width * 9 / 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Requisitos',
                                      style: GoogleFonts.roboto(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width * 9 / 10,
                              child: const Divider(
                                color: Colors.black54,
                                height: 5,
                              ),
                            ),
                            Obx(
                              () => controller.requirements.value.isEmpty
                                  ? const SizedBox()
                                  : Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Wrap(
                                          spacing: 15,
                                          children:
                                              controller.requirements.value.map(
                                            (e) {
                                              return RequirementItem(
                                                requirement: e,
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                    ),
                            ),
                          ],
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
