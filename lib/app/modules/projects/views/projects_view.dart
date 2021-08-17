import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/projects_controller.dart';

class ProjectsView extends GetView<ProjectsController> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var df = DateFormat('dd-MM-yyyy');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: DesktopNavbar(),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  width: screenSize.width * 9 / 10,
                  constraints: BoxConstraints(
                    minHeight: screenSize.height * 8.5 / 10,
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Text(
                              "MIS PROYECTOS",
                              style: GoogleFonts.roboto(
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
                                controller.projects.add(
                                  AgileProject(
                                    titulo: "titulo",
                                    tipo: "tipo",
                                    fecha: DateTime.now(),
                                    cantidad: 5,
                                    visibilidad: true,
                                  ),
                                );
                                controller.listKey.currentState!.insertItem(
                                  0,
                                  duration: Duration(seconds: 1),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.green),
                              ),
                              child: Text(
                                "Nuevo proyecto",
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Proyecto",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Creación",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Tipo de Mercado",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Visibilidad",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 5,
                          color: Colors.black,
                        ),
                      ),
                      Obx(
                        () => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          height: 500,
                          child: AnimatedList(
                            key: controller.listKey,
                            initialItemCount: controller.projects.length,
                            itemBuilder: (context, index, animation) {
                              int i = controller.projects.length - 1 - index;
                              return SizeTransition(
                                sizeFactor: animation,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    color: Colors.red,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            controller.projects[i].titulo!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${df.format(controller.projects[i].fecha!)}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            controller.projects[i].tipo!,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            controller.projects[i].visibilidad
                                                    .value
                                                ? "Público"
                                                : "Privado",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            "${controller.projects[i].cantidad!}",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            "$i",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w400,
                                            ),
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
    );
  }
}
