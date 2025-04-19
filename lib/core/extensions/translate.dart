import 'package:chat_master/config/locale/app_localizations.dart';
import 'package:chat_master/core/utils/app_constants.dart';
import 'package:flutter/material.dart';

extension TranslateY on String {
  String translate(BuildContext context) =>
      AppLocalizations.of(context)!.translate(this);
}

extension TranslateX on String {
  String get tr =>
      AppLocalizations.of(AppConstants.scaffoldKey.currentContext!)!
          .translate(this);
}
