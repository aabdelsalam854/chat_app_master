import 'package:flutter/material.dart';
import 'package:chat_master/core/utils/app_colors.dart';

class TChipTheme {
  TChipTheme._();

  static final lightChipTheme = ChipThemeData(
    selectedColor: AppColors.primary,
    checkmarkColor: Colors.white,
    disabledColor: Colors.grey.withValues(alpha: 0.4),
    labelStyle: const TextStyle(color: Colors.black),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  );

  static const darkChipTheme = ChipThemeData(
    selectedColor: AppColors.primary,
    disabledColor: Colors.grey,
    checkmarkColor: Colors.white,
    labelStyle: TextStyle(color: Colors.white),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
  );
}
