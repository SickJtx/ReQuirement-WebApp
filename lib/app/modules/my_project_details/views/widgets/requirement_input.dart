import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequirementInput extends StatelessWidget {
  const RequirementInput({
    Key? key,
    required this.itemLabel,
    required this.child,
    this.withBorder = true,
  }) : super(key: key);
  final String itemLabel;
  final Widget child;
  final bool withBorder;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      //margin: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemLabel,
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          ),
          Container(
            width: screenSize.width * 1.5 / 8,
            height: screenSize.height * 0.5 / 8,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            constraints: const BoxConstraints(minWidth: 250),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              border: withBorder ? Border.all(color: Colors.black54) : null,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  offset: const Offset(0, 40),
                  blurRadius: 80,
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
