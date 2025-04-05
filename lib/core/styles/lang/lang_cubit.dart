import 'package:chat_master/core/utils/server_locator.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'lang_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial()) {
    final isEnglish = sl.get<SharedPreferences>().getBool('isEnglish') ?? true;
    emit(LanguageChanged((isEnglish ? "en" : "ar")));
  }

  void changeLanguages() {
    final isEnglish = !(state is LanguageChanged &&
        (state as LanguageChanged).locale == "en");
    emit(LanguageChanged((isEnglish ? "en" : "ar")));
    sl.get<SharedPreferences>().setBool('isEnglish', isEnglish);
  }
}
