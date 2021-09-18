import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final df = DateFormat('dd-MM-yyyy');
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
                                      "PROYECTOS PÚBLICOS",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                        "Proyecto",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Creación",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Tipo de Mercado",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "Visibilidad",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "#Requisitos",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Acciones",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
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
                                      horizontal: 20),
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
                                              "/projects/my-project-details",
                                            );
                                            await Get.find<
                                                    MyProjectDetailsController>()
                                                .getProjectInfo(
                                                    pid: map["id"].toString());
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20),
                                            //olor: Colors.red,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    map["projectName"]
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    df.format(DateTime.parse(
                                                        map["createdAt"]
                                                            .toString())),
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
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
                                                    style: GoogleFonts.roboto(
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
                                                        ? "Público"
                                                        : "Privado",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "0",
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.roboto(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                    flex: 2,
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
                                                          onPressed: () {
                                                            Get.toNamed(
                                                                "/projects/my-project-details");
                                                          },
                                                          style: OutlinedButton
                                                              .styleFrom(
                                                            primary: active,
                                                            side:
                                                                const BorderSide(
                                                                    color:
                                                                        active),
                                                          ),
                                                          child:
                                                              const Text("Ver"),
                                                        ),
                                                        const Expanded(
                                                          child: SizedBox(
                                                            width: 1,
                                                          ),
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () {},
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        active),
                                                          ),
                                                          child: const Text(
                                                              "Clonar"),
                                                        ),
                                                        const Expanded(
                                                          flex: 2,
                                                          child: SizedBox(
                                                            width: 1,
                                                          ),
                                                        )
                                                      ],
                                                    )),
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