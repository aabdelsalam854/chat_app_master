import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      ResponsiveSizes.screenWidth = constraints.maxWidth;
      ResponsiveSizes.screenHeight = constraints.maxHeight;
      ResponsiveSizes.setScreenSize(constraints);
      return child;
    });
  }
}

class ResponsiveSizes {
  static double? screenWidth;
  static double? screenHeight;
  static void setScreenSize(BoxConstraints constraints) {
    screenWidth = constraints.maxWidth;
    screenHeight = constraints.maxHeight;
  }
}
