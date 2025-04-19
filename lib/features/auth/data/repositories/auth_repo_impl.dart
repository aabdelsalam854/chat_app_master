import 'package:chat_master/core/constant/cached_key.dart';
import 'package:chat_master/core/constant/endpoint.dart';
import 'package:chat_master/core/encryption/encryption.dart';
import 'package:chat_master/core/error/failures.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/database_services.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/auth/data/datasources/auth_remote.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';

import 'package:chat_master/features/auth/domain/entities/user_entity.dart';
import 'package:chat_master/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;
  final DatabaseServices databaseServices;

  AuthRepositoryImpl(
    this.dataSource,
    this.databaseServices,
  );

  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    try {
      final res = await dataSource.login(email, password);

      res.uid;
      sl<SharedPreferences>().setString(CachedKey.uid, res.uid.encrypt());
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
          docId: res.uid,
          path: EndPoint.userCollection,
          data: UserModel(
            id: res.uid,
            phoneNumber: null,
            name: registerModel.name,
            email: registerModel.email,
            photoUrl: null,
            lastSeen: null,
          ).toJson());

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
