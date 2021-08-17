import 'package:get/get.dart';

String? validateEmail(String value) {
  if (!GetUtils.isEmail(value)) {
    return "Correo ingresado no valido";
  }
  return null;
}
