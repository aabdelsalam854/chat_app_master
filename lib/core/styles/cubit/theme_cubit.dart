import 'package:chat_master/core/enums/theme.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial( AppTheme.themeLight)) {
    final isLight = sl.get<SharedPreferences>().getBool('isLight') ?? true;
    emit(ThemeChanged(isLight ? AppTheme.themeLight : AppTheme.themeDark));
  }

  /// Toggles the current theme between light and dark modes.
  ///
  /// This method checks the current theme state and switches it to the opposite theme.
  /// It updates the theme state by emitting a new `ThemeChanged` event with the new theme.
  /// Additionally, it saves the new theme preference to `SharedPreferences` for persistence.

  void changeTheme() {
    final isLight = !(state is ThemeChanged &&
        (state as ThemeChanged).appTheme == AppTheme.themeLight);
    emit(ThemeChanged(isLight ? AppTheme.themeLight : AppTheme.themeDark));
    sl.get<SharedPreferences>().setBool('isLight', isLight);
  }
}
