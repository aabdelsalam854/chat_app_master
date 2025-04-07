import 'package:chat_master/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppLocalDataSource {
  Future<String> getSavedLang();
  Future<bool> changeLang(String langCode);
}

class AppLocalDataSourceImpl implements AppLocalDataSource {
  final SharedPreferences shared;

  AppLocalDataSourceImpl(this.shared);
  @override
  Future<bool> changeLang(String langCode) async =>
      await shared.setString(AppStrings.locale, langCode);

  @override
  Future<String> getSavedLang() async => shared.containsKey(AppStrings.locale)
      ? shared.getString(AppStrings.locale)!
      : AppStrings.arCode;
}
