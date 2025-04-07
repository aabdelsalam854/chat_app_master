import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/features/auth/data/datasources/auth_remote.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/domain/entities/user_entity.dart';
import 'package:chat_master/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
    final DatabaseServices databaseServices;

  AuthRepositoryImpl(
    this.dataSource, this.databaseServices,
  );

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final res = await dataSource.login(email, password);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      RegisterModel registerModel) async {
    try {
      final res = await dataSource.register(RegisterModel(
          name: registerModel.name,
          phoneNumber: registerModel.phoneNumber,
          email: registerModel.email,
          password: registerModel.password,
          covariantPassword: registerModel.covariantPassword));

databaseServices.addData(
          docId: res.uid, path: EndPoint.userCollection,
          data: {
            'name': registerModel.name,
            'phoneNumber': registerModel.phoneNumber,
            'email': registerModel.email,
            'password': registerModel.password,
            'covariantPassword': registerModel.covariantPassword
          });
  
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(String email) async {
    try {
      final res = await dataSource.resetPassword(email);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(e.message ?? ''));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
