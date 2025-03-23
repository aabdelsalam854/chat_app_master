import 'package:chat_master/core/error/fire_base_error.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAndRegisterRepo {
  Future<Either<Fuiler, UserCredential>> register(
      String emailAddress, final String password);

  Future<Either<Fuiler, UserCredential>> login(
      String emailAddress, final String password);
}
