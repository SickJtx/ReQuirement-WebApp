import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledItem extends StatelessWidget {
  const LabeledItem({Key? key, required this.itemLabel, required this.child})
      : super(key: key);
  final String itemLabel;
  final Widget child;

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
            height: 15,
          ),
          Container(
            width: screenSize.width * 2 / 8,
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
            child: child,
          ),
        ],
      ),
    );
  }
}
