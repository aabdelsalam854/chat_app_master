
import 'package:chat_master/features/home/data/datasources/messages_remote.dart';
import 'package:chat_master/features/home/data/repositories/messages_repo_impl.dart';
import 'package:chat_master/features/home/domain/repositories/messages_repo.dart';
import 'package:chat_master/features/home/domain/usecases/messages.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';


Future<void> homeInjection(GetIt sl) async {
  // Cubit
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  // Use cases
  sl.registerFactory<MessagesUsecases >(() => MessagesUsecases (sl()));

  // Repository
  sl.registerLazySingleton<MessageRepository>(() => MessageRepositoryImpl(sl() ));

  // Data Sources
  sl.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessageRemoteDataSourceImpl(sl()));
}
