import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/modules/profile/controllers/profile_controller.dart';

class ProfileItem extends GetView<ProfileController> {
  const ProfileItem({
    Key? key,
    required this.itemLabel,
    required this.textController,
    required this.editor,
    required this.onChange,
    required this.infoLabel,
  }) : super(key: key);

  final String itemLabel;
  final void Function(String) onChange;
  final String infoLabel;
  final TextEditingController textController;
  final bool editor;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemLabel,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 14,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 250),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 40),
                  blurRadius: 80,
                ),
              ],
            ),
            child: Container(
              width: screenSize.width * 4 / 14,
              padding: const EdgeInsets.only(left: 8),
              child: editor
                  ? Text(
                      infoLabel,
                      style: GoogleFonts.roboto(),
                    )
                  : TextField(
                      onChanged: onChange,
                      enabled: editor,
                      controller: textController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
