// import 'package:chat_master/features/app/app_injection.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:chat_master/core/network/network_info.dart';
// // import 'package:chat_master/core/helpers/api/api_consumer.dart';
// // import 'package:chat_master/core/helpers/api/dio_consumer.dart';
// // import 'package:chat_master/core/helpers/api/app_interceptors.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:chat_master/core/helpers/notification/local_notify.dart';
// // // import 'package:chat_master/core/helpers/notification/notify_service.dart';
// // import 'package:internet_connection_checker/internet_connection_checker.dart';

// final sl = GetIt.instance;
// Future<void> init() async {
//   // await FMServices.initialize();
//   // await LocalNotifyService.initialize();
//   //! Features
//   await appInit(sl);

//   // // ! Core
//   // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//   //! External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   // sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

//   // sl.registerLazySingleton(() => AppInterceptors());
//   // sl.registerLazySingleton(() => InternetConnectionChecker.I);
//   sl.registerLazySingleton(() => LogInterceptor(
//       request: true,
//       requestBody: true,
//       requestHeader: true,
//       responseBody: true,
//       responseHeader: true,
//       error: true));
//   sl.registerLazySingleton(() => Dio());
// }
