import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/profile/data/datasources/profile_remote.dart';
import 'package:chat_master/features/profile/domain/repositories/profile_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(this.profileRemoteDataSource);

  @override
  Future<Either<Failure, dynamic>> updatePassword(String password) async {
    try {
      var data = await profileRemoteDataSource.updatePassword(password);

      return right(data);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(UserModel userModel) async {
    try {
      var data = await profileRemoteDataSource.updateProfile(userModel);

      return right(data);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData(String uid) async {
    try {
      final userData = await profileRemoteDataSource.getUserData(uid);
      return Right(userData);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
