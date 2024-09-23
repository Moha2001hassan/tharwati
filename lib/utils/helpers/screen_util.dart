import 'package:flutter/material.dart';

class ScreenUtil {
  // Singleton pattern for easy access
  static final ScreenUtil _instance = ScreenUtil._internal();

  factory ScreenUtil() {
    return _instance;
  }

  ScreenUtil._internal();

  late double screenWidth;
  late double screenHeight;
  late double blockWidth;
  late double blockHeight;

  void init(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;
  }

  double width(double percentage) {
    return blockWidth * percentage;
  }

  double height(double percentage) {
    return blockHeight * percentage;
  }
}