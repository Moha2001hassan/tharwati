import 'package:flutter/material.dart';

import '../constants/colors.dart';
import 'custom_themes/elevated_btn_theme.dart';
import 'custom_themes/fab_theme.dart';
import 'custom_themes/outlined_btn_theme.dart';
import 'custom_themes/text_field_theme.dart';

class MyAppTheme {
  MyAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: MyColors.white,
    inputDecorationTheme: MyTextFormFieldTheme.lightInputDecorationTheme,
    elevatedButtonTheme: MyElevatedBtnTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MyOutLinedBtnTheme.lightOutlinedButtonTheme,
    //appBarTheme: MyAppBarTheme.lightAppBarTheme,
    floatingActionButtonTheme: MyFabTheme.lightFloatingActionButtonTheme,
  );


}