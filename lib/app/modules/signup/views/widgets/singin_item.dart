import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SigninItem extends StatelessWidget {
  const SigninItem({
    Key? key,
    required this.itemLabel,
    required this.textController,
    this.obscure = false,
  }) : super(key: key);
  final String itemLabel;
  final TextEditingController textController;
  final bool obscure;
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
                    blurRadius: 80),
              ],
            ),
            child: Container(
              width: screenSize.width * 4 / 14,
              padding: const EdgeInsets.only(left: 8),
              child: TextFormField(
                controller: textController,
                obscureText: obscure,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
