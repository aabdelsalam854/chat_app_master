import 'package:chat_master/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:chat_master/core/error/failures.dart';

import 'package:chat_master/features/app/domain/repositories/app_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final AppRepository appRepository;

  ChangeLangUseCase({required this.appRepository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await appRepository.changeLang(langCode);
}
