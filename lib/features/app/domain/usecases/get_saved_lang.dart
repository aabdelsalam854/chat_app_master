import 'package:dartz/dartz.dart';
import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/usecases/usecase.dart';
import 'package:chat_master/features/app/domain/repositories/app_repository.dart';

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final AppRepository appRepository;

  GetSavedLangUseCase({required this.appRepository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await appRepository.getSavedLang();
}
