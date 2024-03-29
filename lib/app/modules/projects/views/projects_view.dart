import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/step1_view.dart';
import 'package:re_quirement/app/modules/projects/views/widgets/step3_view.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';

import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/projects_controller.dart';
import 'widgets/step2_view.dart';

class ProjectsView extends GetView<ProjectsController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final df = DateFormat('dd-MM-yyyy');
    Get.find<NavbarController>().showCurrent();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                          color: Colors.white,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .myProjectsProjects,
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        child: Container(),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                          title: AppLocalizations.of(context)!
                                              .newProjectProjects,
                                          titleStyle: GoogleFonts.montserrat(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          barrierDismissible: false,
                                          content: Obx(
                                            () => AnimatedSwitcher(
                                              switchInCurve: Curves.slowMiddle,
                                              duration: const Duration(
                                                  milliseconds: 500),
                                              child: controller.step.value == 1
                                                  ? const Step1()
                                                  : controller.step.value == 2
                                                      ? const Step2()
                                                      : const Step3(),
                                            ),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.green,
                                        ),
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .newProjectProjects,
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        await controller.importProject();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.orange),
                                      ),
                                      child: const Text("Importar de excel"),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .projectProjects,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .creationProjects,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .typeOfMarketProjects,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .visibilityProjects,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .actionsProjects,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Divider(
                                  height: 5,
                                  color: Colors.black,
                                ),
                              ),
                              Obx(
                                () => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  height: 500,
                                  child: AnimatedList(
                                    key: controller.listKey,
                                    initialItemCount:
                                        controller.projects.length,
                                    itemBuilder: (context, index, animation) {
                                      final map = controller.projects[index];
                                      return SizeTransition(
                                        sizeFactor: animation,
                                        child: InkWell(
                                          onTap: () async {
                                            Get.toNamed(
                                                "/projects/my-project-details");
                                            await Get.find<
                                                    MyProjectDetailsController>()
                                                .getProjectInfo(
                                              pid: map["id"].toString(),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    map["projectName"]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    df.format(
                                                      DateTime.parse(
                                                        map["createdAt"]
                                                            .toString(),
                                                      ),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    map["marketType"]
                                                            ["marketTypeName"]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    map["visibility"]
                                                                .toString() ==
                                                            "PUBLIC"
                                                        ? AppLocalizations.of(
                                                                context)!
                                                            .visibilityPublicProjects
                                                        : AppLocalizations.of(
                                                                context)!
                                                            .visibilityPrivateProjects,
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          width: 1,
                                                        ),
                                                      ),
                                                      OutlinedButton(
                                                        onPressed: () async {
                                                          Get.toNamed(
                                                              "/projects/my-project-details");
                                                          await Get.find<
                                                                  MyProjectDetailsController>()
                                                              .getProjectInfo(
                                                            pid: map["id"]
                                                                .toString(),
                                                          );
                                                        },
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          primary: active,
                                                          side:
                                                              const BorderSide(
                                                            color: active,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .watchProjects,
                                                        ),
                                                      ),
                                                      const Expanded(
                                                        child: SizedBox(
                                                          width: 1,
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Get.defaultDialog(
                                                            title: "Aviso",
                                                            content: SizedBox(
                                                              width: screenSize
                                                                      .width *
                                                                  2 /
                                                                  3,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        20),
                                                                child: Column(
                                                                  children: [
                                                                    const Text(
                                                                        "Si elimina el proyecto se perderá toda la información y no podrá ser recuperada. ¿Esta seguro de que desea borrar el proyecto?"),
                                                                    const SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        const Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        OutlinedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          style:
                                                                              OutlinedButton.styleFrom(
                                                                            primary:
                                                                                Colors.red,
                                                                            //side: const BorderSide(color: Colors.red),
                                                                          ),
                                                                          child:
                                                                              Text(AppLocalizations.of(context)!.cancelLabelStep3),
                                                                        ),
                                                                        const Expanded(
                                                                          child:
                                                                              SizedBox(
                                                                            width:
                                                                                1,
                                                                          ),
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed:
                                                                              () async {
                                                                            Get.back();
                                                                            await controller.deleteProject(map["id"]
                                                                                as int);
                                                                          },
                                                                          style:
                                                                              ButtonStyle(
                                                                            backgroundColor:
                                                                                MaterialStateProperty.all(Colors.green),
                                                                          ),
                                                                          child:
                                                                              const Text("Aceptar"),
                                                                        ),
                                                                        const Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              SizedBox(width: 1),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .red),
                                                        ),
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .eraseProjects),
                                                      ),
                                                      const Expanded(
                                                        flex: 2,
                                                        child: SizedBox(
                                                          width: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
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
      ),
    );
  }
}
