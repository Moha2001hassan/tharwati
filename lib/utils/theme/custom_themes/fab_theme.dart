import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class MyFabTheme {
  MyFabTheme._();

  // light theme
  static final lightFloatingActionButtonTheme = FloatingActionButtonThemeData(
    backgroundColor: MyColors.primary,
    foregroundColor: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );


}