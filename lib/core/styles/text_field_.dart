import 'package:chat_master/core/styles/app_color.dart';
import 'package:flutter/material.dart';



class TextFieldTheme {
  TextFieldTheme._();

  static InputDecorationTheme lightTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    filled: true,
    suffixIconColor: Colors.grey,
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: const TextStyle(fontWeight: FontWeight.normal),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.black.withOpacity(.8)),
    border: buildBorder(),
    enabledBorder: buildBorder(),
    focusedBorder: buildBorder(),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 2, color: Colors.orange),
    ),
    fillColor: const Color(0XFFF9FAFA),
    suffixStyle: const TextStyle(
      color: Colors.black,
    ),
    prefixStyle: const TextStyle(
      color: Colors.black,
    ),
  );

  static OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Color(0XFFE6E9E9)),
    );
  }

  static InputDecorationTheme darkTextFieldTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.white70,
    suffixIconColor: Colors.white70,
    filled: true,
    fillColor: const Color(0xFF2B2B2B),
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white70),
    errorStyle:
        const TextStyle(fontWeight: FontWeight.normal, color: Colors.redAccent),
    floatingLabelStyle:
        const TextStyle().copyWith(color: Colors.white.withOpacity(.8)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: Colors.white70),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: Colors.white54),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 2, color: AppColors.kCustomBottomColors),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: Colors.redAccent),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 2, color: Colors.orangeAccent),
    ),
    suffixStyle: const TextStyle(
      color: Colors.white,
    ),
    prefixStyle: const TextStyle(
      color: Colors.white,
    ),
  );
}
