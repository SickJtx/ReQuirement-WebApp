import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.itemLabel,
    required this.controller,
    required this.editor,
  }) : super(key: key);
  final String itemLabel;
  final TextEditingController controller;
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
            style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
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
                    blurRadius: 80),
              ],
            ),
            child: Container(
              width: screenSize.width * 4 / 14,
              padding: const EdgeInsets.only(left: 8),
              child: TextField(
                enabled: editor,
                controller: controller,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
