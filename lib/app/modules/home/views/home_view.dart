import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:re_quirement/app/utils/widgets/appbar/desktop_navbar.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  constraints: BoxConstraints(
                      minHeight: screenSize.height * 8.5 / 10,
                      minWidth: screenSize.width * 9 / 10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: Column(
                    children: [
                      Text(
                        'Home view is working',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
