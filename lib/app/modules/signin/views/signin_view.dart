import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_quirement/app/utils/controllers/navbar_controller.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/signin_controller.dart';

class SigninView extends GetView<SigninController> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: DesktopNavbar(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: screenSize.height / 15,
                  ),
                  Container(
                    width: screenSize.width * 5 / 7,
                    height: screenSize.width < 815
                        ? 800
                        : screenSize.height < 680
                            ? 550
                            : screenSize.height * 3 / 4,
                    padding: EdgeInsets.all(20),
                    color: Colors.white,
                    //constraints: BoxConstraints(minHeight: 900),
                    child: Column(
                      children: [
                        Text(
                          "Crear Cuenta",
                          style: GoogleFonts.roboto(
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                        Wrap(
                          children: [
                            signinItem(
                              itemLabel: "Nombre",
                            ),
                            signinItem(
                              itemLabel: "Apellido",
                            ),
                          ],
                        ),
                        signinItem(
                          itemLabel: "Correo",
                        ),
                        Wrap(
                          children: [
                            signinItem(
                              itemLabel: "Contraseña",
                            ),
                            signinItem(
                              itemLabel: "Repetir Contraseña",
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            signinItem(
                              itemLabel: "Dirección 1",
                            ),
                            signinItem(
                              itemLabel: "Dirección 2",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          height: 40,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text("REGISTRAR",
                                style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: Colors.white70,
                                    fontWeight: FontWeight.w300)),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green),
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
      ),
    );
  }
}

class signinItem extends StatelessWidget {
  const signinItem({
    Key? key,
    required this.itemLabel,
  }) : super(key: key);
  final String itemLabel;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemLabel,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 7,
          ),
          Container(
            constraints: BoxConstraints(minWidth: 250),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    offset: Offset(0, 40),
                    blurRadius: 80),
              ],
            ),
            child: Container(
              width: screenSize.width * 4 / 14,
              padding: EdgeInsets.only(left: 8),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
