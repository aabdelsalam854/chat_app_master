import 'package:chat_master/core/error/exceptions.dart';
import 'package:chat_master/core/error/failures.dart';

import 'package:dartz/dartz.dart';

import 'package:chat_master/features/app/domain/repositories/app_repository.dart';
import 'package:chat_master/features/app/data/datasources/app_local_data_source.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource appLocalDataSource;

  AppRepositoryImpl({required this.appLocalDataSource});

  @override
  Future<Either<Failure, bool>> changeLang(String langCode) async {
    try {
      final langIsChanged = await appLocalDataSource.changeLang(langCode);
      return Right(langIsChanged);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      final langCode = await appLocalDataSource.getSavedLang();
      return Right(langCode);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg.toString()));
    }
  }
}
