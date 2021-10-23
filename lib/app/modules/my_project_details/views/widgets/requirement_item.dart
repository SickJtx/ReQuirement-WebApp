import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/modules/my_project_details/controllers/my_project_details_controller.dart';

class RequirementItem extends StatelessWidget {
  const RequirementItem({
    Key? key,
    required this.requirement,
  }) : super(key: key);
  final Requirement requirement;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
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
              Text(requirement.codigo!),
              const Expanded(
                child: SizedBox(
                  width: 1,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: "Detalles",
                      content: SizedBox(
                        width: screenSize.width * 2 / 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Actor: ",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(requirement.actor!,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Descripción: ",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(requirement.detalles!,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Objetivo: ",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(requirement.goal!,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400)),
                              const SizedBox(
                                height: 10,
                              ),
                              Text("Tipo: ",
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500)),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(requirement.type!,
                                  style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                        ),
                      ));
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
                    width: 100, height: 30, child: Text(requirement.detalles!)),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(requirement.prioridad!)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
