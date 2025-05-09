import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/core/services/firebase_auth_services.dart';
import 'package:chat_master/core/services/firestore_services.dart';
import 'package:chat_master/features/app/app_injection.dart';
import 'package:chat_master/features/auth/injection.dart';
import 'package:chat_master/features/chat/injection.dart';
import 'package:chat_master/features/home/injection.dart';
import 'package:chat_master/features/profile/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> setUpServerLocator() async {
  sl.registerSingleton<FirebaseAuthServices>(FirebaseAuthServices());
  sl.registerSingleton<DatabaseServices>((FirestoreServices()));
  await appInit(sl);
  await homeInjection(sl);
  await autInjection(sl);
  await profileInjection(sl);
  await chatInjection(sl);
  sl.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
}
