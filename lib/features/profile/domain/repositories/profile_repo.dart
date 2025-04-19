import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserModel>> updateProfile(UserModel userModel);
  Future<Either<Failure, dynamic>> updatePassword(String password);
  Future<Either<Failure, UserModel>> getUserData(String uid);
}
