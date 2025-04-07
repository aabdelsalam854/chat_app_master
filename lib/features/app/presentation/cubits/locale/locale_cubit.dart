import 'package:chat_master/core/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_master/core/usecases/usecase.dart';
import 'package:chat_master/core/utils/app_strings.dart';

import 'package:chat_master/core/utils/app_constants.dart';
import 'package:chat_master/features/app/domain/usecases/change_lang.dart';
import 'package:chat_master/features/app/domain/usecases/get_saved_lang.dart';
part 'locale_state.dart';

String currentLangCode = '';

class LocaleCubit extends Cubit<LocaleState> {
  final ChangeLangUseCase changeLangUseCase;
  final GetSavedLangUseCase getSavedLangUseCase;
  LocaleCubit(
    this.changeLangUseCase,
    this.getSavedLangUseCase,
  ) : super(const ChangeLocaleState(
          locale: Locale(AppStrings.arCode),
          fontFamily: AppConstants.fontFamilyAr,
        ));

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold(
      (failure) => debugPrint(AppStrings.cacheFailure),
      (value) {
        currentLangCode = value;
        final fontFamily =
            isArabic ? AppConstants.fontFamilyAr : AppConstants.fontFamilyEn;
        emit(ChangeLocaleState(locale: Locale(value), fontFamily: fontFamily));
      },
    );
  }

  Future<void> _changeLang(String langCode) async {
    final response = await changeLangUseCase.call(langCode);
    response.fold(
      (failure) => debugPrint(AppStrings.cacheFailure),
      (value) {
        currentLangCode = langCode;
        final fontFamily =
            isArabic ? AppConstants.fontFamilyAr : AppConstants.fontFamilyEn;
        emit(ChangeLocaleState(
            locale: Locale(langCode), fontFamily: fontFamily));
      },
    );
  }

  String? groupValue;
  void toEnglish() => _changeLang(AppStrings.enCode);

  void toArabic() => _changeLang(AppStrings.arCode);
}
