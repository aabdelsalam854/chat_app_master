import 'package:chat_master/features/chat/data/datasources/chat_remote.dart';
import 'package:chat_master/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:chat_master/features/chat/domain/repositories/chat_repo.dart';
import 'package:chat_master/features/chat/domain/usecases/chat_usecase.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> chatInjection(GetIt sl) async {
  // Cubit
  sl.registerFactory<ChatCubit>(() => ChatCubit(sl()));
  // Use cases
  sl.registerFactory<ChatUsecases>(() => ChatUsecases(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(sl()));

  // Data Sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(sl()));
}
