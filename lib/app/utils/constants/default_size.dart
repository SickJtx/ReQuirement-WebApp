import 'package:flutter/widgets.dart';

double defaultSize(context) {
  var deviceData = MediaQuery.of(context);
  double height = deviceData.size.height;
  double width = deviceData.size.width;
  print(height * 0.025);
  return (height > width) ? height * 0.025 : width * 0.025;
}

Size deviceSize(context) {
  return MediaQuery.of(context).size;
}
