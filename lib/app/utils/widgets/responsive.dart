import 'package:flutter/material.dart';

int smallScreenWidht = 852;
int largeScreenWidht = 1200;

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget(
      {Key? key,
      @required this.largeScreen,
      this.mediumScreen,
      this.smallScreen})
      : super(key: key);
  final Widget? largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < smallScreenWidht;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width > largeScreenWidht;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= smallScreenWidht &&
      MediaQuery.of(context).size.width <= largeScreenWidht;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double maxWidth = constraints.maxWidth;
      if (maxWidth > largeScreenWidht)
        return largeScreen!;
      else if (maxWidth >= smallScreenWidht && maxWidth <= largeScreenWidht)
        return mediumScreen ?? largeScreen!;
      else
        return smallScreen ?? largeScreen!;
    });
  }
}
