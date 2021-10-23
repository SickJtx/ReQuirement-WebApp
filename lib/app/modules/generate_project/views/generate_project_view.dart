import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';
import 'package:re_quirement/app/utils/widgets/labeled_item.dart';
import 'package:re_quirement/app/utils/widgets/tag_item.dart';

import '../controllers/generate_project_controller.dart';

class GenerateProjectView extends GetView<GenerateProjectController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final map = Get.arguments;
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
                              map["projectName"].toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Wrap(
                              children: [
                                LabeledItem(
                                  itemLabel: AppLocalizations.of(context)!
                                      .typeOfMarketGenerateProject,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      map["marketType"].toString(),
                                    ),
                                  ),
                                ),
                                LabeledItem(
                                  itemLabel: AppLocalizations.of(context)!
                                      .visibilityGenerateProject,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      map["visibility"].toString(),
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
                                AppLocalizations.of(context)!
                                    .projectTagsGenerateProject,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Obx(
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
                            ),
                            SizedBox(
                              width: screenSize.width * 9 / 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .requirementsGenerateProject,
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      ),
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
