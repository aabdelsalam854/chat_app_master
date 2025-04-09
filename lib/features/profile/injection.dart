



import 'package:chat_master/features/profile/data/datasources/profile_remote.dart';
import 'package:chat_master/features/profile/data/repositories/profile_repo_impl.dart';
import 'package:chat_master/features/profile/domain/repositories/profile_repo.dart';
import 'package:chat_master/features/profile/domain/usecases/usecases.dart';
import 'package:chat_master/features/profile/presentation/cubit/profile_cubit.dart';

import 'package:get_it/get_it.dart';


Future<void> profileInjection(GetIt sl) async {
  // Cubit
  sl.registerFactory<ProfileCubit>(() =>ProfileCubit(sl()));
  // Use cases
  sl.registerFactory<ProfileUsecases >(() => ProfileUsecases (sl()));

  // Repository
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl() ));

  // Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(sl()));
}
