import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController controller;
  final dynamic inputValidation;
  final String inputValue;
  final IconData icon;
  final String hintText;
  final String labelText;
  final TextInputType inputType;
  final Function inputSetter;

  const CustomFormField({
    Key? key,
    required this.controller,
    required this.inputValidation,
    required this.inputType,
    required this.icon,
    required this.hintText,
    required this.inputValue,
    required this.labelText,
    required this.inputSetter,
  }) : super(key: key);
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      onSaved: (value) {
        setState(() {
          widget.inputSetter(value!);
        });
      },
      validator: (value) {
        return widget.inputValidation(value!);
      },
      style: const TextStyle(
        fontFamily: 'Montserrat',
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.montserrat(
          color: lightGrayText,
          fontWeight: FontWeight.w300,
        ),
        labelText: widget.labelText,
        labelStyle: GoogleFonts.montserrat(
          color: lightGrayText,
          fontWeight: FontWeight.w300,
        ),
        prefixIcon: Icon(
          widget.icon,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: lightGray,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: active,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(13.0),
        ),
      ),
    );
  }
}
