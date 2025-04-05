import 'package:chat_master/core/enums/theme.dart';
import 'package:chat_master/core/styles/app_color.dart';
import 'package:flutter/material.dart';

import 'text_button_style.dart';
import 'text_field_.dart';

final appThemeData = {
  AppTheme.themeLight: ThemeData(
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
      fontFamily: "Cairo",
      scaffoldBackgroundColor: Colors.white,
      colorScheme:
          ColorScheme.fromSeed(seedColor: AppColors.kCustomBottomColors),
      inputDecorationTheme: TextFieldTheme.lightTextFieldTheme,
      textButtonTheme: TextButtonStyle.light),
  AppTheme.themeDark: ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Cairo",
      inputDecorationTheme: TextFieldTheme.darkTextFieldTheme,
      textButtonTheme: TextButtonStyle.dark),
};
