import 'package:chat_master/config/themes/custom_theme/app_bar_theme.dart';
import 'package:chat_master/config/themes/custom_theme/bottom_sheet_theme.dart';
import 'package:chat_master/config/themes/custom_theme/checkbox_theme.dart';
import 'package:chat_master/config/themes/custom_theme/chip_theme.dart';
import 'package:chat_master/config/themes/custom_theme/elevated_button_theme.dart';
import 'package:chat_master/config/themes/custom_theme/outlined_button_theme.dart';
import 'package:chat_master/config/themes/custom_theme/text_field_theme.dart';
import 'package:chat_master/config/themes/custom_theme/text_theme.dart';
import 'package:chat_master/core/utils/app_colors.dart';
import 'package:flutter/material.dart';


class AppThemes {
  static ThemeData dark(String fontFamily) => _dark(fontFamily);
  static ThemeData light(String fontFamily) => _light(fontFamily);

  static ThemeData _light(String fontFamily) => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        textTheme: TTextTheme.light,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        chipTheme: TChipTheme.lightChipTheme,
        appBarTheme: TAppBarTheme.lightAppBarTheme,
        checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
        scaffoldBackgroundColor: AppColors.primaryBackground,
        bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
        elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
        outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
        inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme,
        colorScheme: const ColorScheme.light(primary: AppColors.primary),
      );

  static ThemeData _dark(String fontFamily) => ThemeData(
        useMaterial3: true,
        fontFamily: fontFamily,
        textTheme: TTextTheme.dark,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        chipTheme: TChipTheme.darkChipTheme,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: TAppBarTheme.darkAppBarTheme,
        checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
        bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
        elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
        outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
        inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
        colorScheme: const ColorScheme.dark(primary: AppColors.primary),
      );
}
