import 'package:chat_master/core/utils/server_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    final isLight = sl.get<SharedPreferences>().getBool('isLight') ?? true;
    emit(ThemeChanged(isLight ? AppTheme.themeLight : AppTheme.themeDark));
  }

  void changeTheme() {
    final isLight = !(state is ThemeChanged &&
        (state as ThemeChanged).appTheme == AppTheme.themeLight);
    emit(ThemeChanged(isLight ? AppTheme.themeLight : AppTheme.themeDark));

    sl.get<SharedPreferences>().setBool('isLight', isLight);
  }
}
