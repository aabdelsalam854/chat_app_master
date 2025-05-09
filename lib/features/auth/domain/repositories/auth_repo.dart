import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';

import 'package:chat_master/features/auth/domain/entities/user_entity.dart';

import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login(String email, String password);
  Future<Either<Failure, UserEntity>> register(RegisterModel registerModel);
  Future<Either<Failure, dynamic>> resetPassword(String email);
}
