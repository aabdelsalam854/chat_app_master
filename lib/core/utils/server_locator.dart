import 'package:chat_master/features/login/data/repo/login_and_register_repo_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../fire_base_auth/fire_base_auth.dart';

final sl = GetIt.instance;
Future<void> setUpServerLocator()  async{

  sl.registerSingleton<FireAuth>(FireAuth(FirebaseAuth.instance));
  sl.registerSingleton<LoginAndRegisterRepoImpl>(
      LoginAndRegisterRepoImpl(sl.get<FireAuth>()));    sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
