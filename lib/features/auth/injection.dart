
import 'package:chat_master/features/auth/data/datasources/auth_remote.dart';
import 'package:chat_master/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:chat_master/features/auth/domain/repositories/auth_repo.dart';
import 'package:chat_master/features/auth/domain/usecases/auth.dart';
import 'package:chat_master/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';


Future<void> autInjection(GetIt sl) async {
  // Cubit
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl()));
  // Use cases
  sl.registerFactory<AuthUseCases>(() => AuthUseCases(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl() , sl()));

  // Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));
}
