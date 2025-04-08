import 'package:chat_master/core/enums/theme.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/usecases/usecase.dart';
import 'package:chat_master/core/utils/app_constants.dart';
import 'package:chat_master/features/app/domain/usecases/change_lang.dart';
import 'package:chat_master/features/app/domain/usecases/get_saved_lang.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_master/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_state.dart';
String currentLangCode = '';
class AppCubit extends Cubit<AppState> {
  final SharedPreferences shared;
  final ChangeLangUseCase changeLangUseCase;
  final GetSavedLangUseCase getSavedLangUseCase;
  AppCubit(this.shared, this.changeLangUseCase, this.getSavedLangUseCase)
      : super(AppInitial(
          Locale(AppStrings.arCode),
          AppConstants.fontFamilyAr,
          AppTheme.themeDark,
        ));

  // Future<bool?> getIsOpenedApp() async {
  //   final val = shared.getBool(AppStrings.isOpenedApp);
  //   return val;
  // }

  // bool isOpened = false;
  // Future<void> isOpenedApp() async {
  //   final check = await getIsOpenedApp();
  //   if (check != null) return;
  //   await shared.setBool(AppStrings.isOpenedApp, true);
  //   isOpened = check ?? false;
  // }

  Future<void> getSavedLang() async {
    final response = await getSavedLangUseCase.call(NoParams());
    response.fold(
      (failure) => debugPrint(AppStrings.cacheFailure),
      (value) {
        currentLangCode = value;
        final fontFamily =
            isArabic ? AppConstants.fontFamilyAr : AppConstants.fontFamilyEn;
        emit(ChangeLocaleState(Locale(value), fontFamily, state.appTheme));
      },
    );
  }

  Future<bool> getSavedTheme() async {
    final isLight = shared.getBool('isLight') ?? true;
    emit(ThemeChanged(state.locale, state.fontFamily,
        isLight ? AppTheme.themeLight : AppTheme.themeDark));
    return isLight;
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
            Locale(langCode), fontFamily, AppTheme.themeLight));
      },
    );
  }

  void toEnglish() => _changeLang(AppStrings.enCode);

  void toArabic() => _changeLang(AppStrings.arCode);

  void changeTheme() {
    final themeMode = state.appTheme != AppTheme.themeLight ? true : false;

    emit(ThemeChanged(
      state.locale,
      state.fontFamily,
      themeMode ? AppTheme.themeLight : AppTheme.themeDark,
    ));
    sl.get<SharedPreferences>().setBool('isLight', themeMode);
  }
}
