import 'package:dartz/dartz.dart';
import 'package:chat_master/core/error/failures.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> getSavedLang();
  Future<Either<Failure, bool>> changeLang(String langCode);
}
