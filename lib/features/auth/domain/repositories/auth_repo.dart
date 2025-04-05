import 'package:chat_master/core/error/failure.dart';


import 'package:chat_master/features/auth/domain/entities/user_entity.dart';

import 'package:dartz/dartz.dart';


abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(String email, String password , String covariantPassword);

}
