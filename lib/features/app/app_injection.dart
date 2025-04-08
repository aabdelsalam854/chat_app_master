import 'package:get_it/get_it.dart';
import 'domain/usecases/change_lang.dart';
import 'domain/usecases/get_saved_lang.dart';
import 'presentation/cubits/app/app_cubit.dart';
import 'domain/repositories/app_repository.dart';
import 'data/repositories/app_repository_impl.dart';
import 'data/datasources/app_local_data_source.dart';
// import 'presentation/cubits/locale/locale_cubit.dart';

Future<void> appInit(GetIt sl) async {
  // Blocs
  sl.registerFactory<AppCubit>(() => AppCubit(sl(), sl(), sl()));
  // sl.registerFactory<LocaleCubit>(() => LocaleCubit(sl(), sl()));

  // Use cases
  sl.registerLazySingleton<ChangeLangUseCase>(
      () => ChangeLangUseCase(appRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
      () => GetSavedLangUseCase(appRepository: sl()));

  // Repository
  sl.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(appLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<AppLocalDataSource>(
      () => AppLocalDataSourceImpl(sl()));
}
