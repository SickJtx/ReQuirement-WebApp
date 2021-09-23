import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:re_quirement/app/utils/constants/styles.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';
import 'package:re_quirement/app/utils/widgets/custom_form_field.dart';

import '../controllers/signup_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: bgColor,
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
              : GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width / 6,
                                ),
                                child: Form(
                                  key: controller.signupFormKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Text(
                                        "Crear Cuenta",
                                        style: GoogleFonts.montserrat(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.firstNameController,
                                        inputValidation:
                                            controller.validateOnlyLetters,
                                        inputType: TextInputType.text,
                                        icon: Icons.person_outline,
                                        hintText: 'Ingresa tu Nombre',
                                        labelText: 'Nombre',
                                        inputValue: controller.firstName,
                                        inputSetter: (String value) {
                                          controller.firstName = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.lastNameController,
                                        inputValidation:
                                            controller.validateOnlyLetters,
                                        inputType: TextInputType.text,
                                        icon: Icons.person_outline,
                                        hintText: 'Ingresa tu Apellido',
                                        labelText: 'Apellido',
                                        inputValue: controller.lastName,
                                        inputSetter: (String value) {
                                          controller.lastName = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.usernameController,
                                        inputValidation:
                                            controller.validateEmail,
                                        inputType: TextInputType.emailAddress,
                                        icon: Icons.email_outlined,
                                        hintText: 'Ingresa tu correo',
                                        labelText: 'Correo',
                                        inputValue: controller.username,
                                        inputSetter: (String value) {
                                          controller.username = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.passwordController,
                                        inputValidation:
                                            controller.validatePassword,
                                        inputType:
                                            TextInputType.visiblePassword,
                                        icon: Icons.lock_outline,
                                        hintText: 'Ingresa tu contraseña',
                                        labelText: 'Contraseña',
                                        inputValue: controller.password,
                                        inputSetter: (String value) {
                                          controller.password = value;
                                        },
                                        obscure: true,
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.repeatPasswordController,
                                        inputValidation:
                                            controller.validateRetypePassword,
                                        inputType:
                                            TextInputType.visiblePassword,
                                        icon:
                                            Icons.enhanced_encryption_outlined,
                                        hintText: 'Repite tu contraseña',
                                        labelText: 'Repetir Contraseña',
                                        inputValue: controller.repeatPassword,
                                        inputSetter: (String value) {
                                          controller.repeatPassword = value;
                                        },
                                        obscure: true,
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller:
                                            controller.primaryAddressController,
                                        inputValidation:
                                            controller.validateAdress,
                                        inputType: TextInputType.streetAddress,
                                        icon: Icons.home_outlined,
                                        hintText:
                                            'Ingresa tu dirección principal',
                                        labelText: 'Dirección principal',
                                        inputValue: controller.primaryAddress,
                                        inputSetter: (String value) {
                                          controller.primaryAddress = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      CustomFormField(
                                        controller: controller
                                            .secundaryAddressController,
                                        inputValidation:
                                            controller.validateAdress,
                                        inputType: TextInputType.streetAddress,
                                        icon: Icons.business_outlined,
                                        hintText:
                                            'Ingresa tu dirección secundaria',
                                        labelText: 'Dirección secundaria',
                                        inputValue: controller.secondaryAddress,
                                        inputSetter: (String value) {
                                          controller.secondaryAddress = value;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      SizedBox(
                                        height: 40,
                                        width: 200,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (controller.checkSignup()) {
                                              await controller.signUpUser();
                                            }
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              active,
                                            ),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  13.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Registrarse",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
