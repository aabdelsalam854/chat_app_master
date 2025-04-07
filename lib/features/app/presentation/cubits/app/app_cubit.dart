import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_master/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final SharedPreferences shared;
  AppCubit(this.shared) : super(AppInitial());

  Future<bool?> getIsOpenedApp() async {
    final val = shared.getBool(AppStrings.isOpenedApp);
    return val;
  }

  bool isOpened = false;
  Future<void> isOpenedApp() async {
    final check = await getIsOpenedApp();
    if (check != null) return;
    await shared.setBool(AppStrings.isOpenedApp, true);
    isOpened = check ?? false;
  }

  Future<String?> getUserToken() async {
    final val = shared.getString(AppStrings.tokenKey);
    if (val == null) return null;
    token = val;
    return val;
  }

  Future<void> setUserToken(String token) async =>
      await shared.setString(AppStrings.tokenKey, token);

  Future<void> removeUserToken() async {
    await shared.remove(AppStrings.tokenKey);
  }
}
