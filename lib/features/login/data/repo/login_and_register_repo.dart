
import 'package:chat_master/core/error/failure.dart';
import 'package:chat_master/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAndRegisterRepo {
  Future<Either<Failure, UserCredential>> register(
      String emailAddress, final String password);

  Future<Either<Failure, UserCredential>> login(
      String emailAddress, final String password);
}
