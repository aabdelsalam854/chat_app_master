import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_master/core/utils/app_colors.dart';

class TAppBarTheme {
  TAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    foregroundColor: AppColors.black,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
    // iconTheme: const IconThemeData(size: 24.0, color: Colors.black),
    iconTheme: IconThemeData(
      color: AppColors.black,
    ),

    actionsIconTheme: IconThemeData(size: 24.0, color: Colors.black),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.vertical(
        bottom: Radius.circular(10),
      ),
    ),
  );

  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    foregroundColor: AppColors.black,
    surfaceTintColor: Colors.transparent,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(size: 24.0, color: Colors.white),
    actionsIconTheme: IconThemeData(size: 24.0, color: Colors.white),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.vertical(
        bottom: Radius.circular(10),
      ),
    ),
  );
}
