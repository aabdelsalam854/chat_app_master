import 'package:chat_master/core/error/failure.dart';

import 'package:chat_master/core/fire_base_auth/fire_base_auth.dart';
import 'package:chat_master/features/login/data/repo/login_and_register_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginAndRegisterRepoImpl implements LoginAndRegisterRepo {
  final FireAuth fireAuth;

  LoginAndRegisterRepoImpl(this.fireAuth);

  @override
  Future<Either<Failure, UserCredential>> register(
      String emailAddress, String password) async {
    try {
      final res =
          await fireAuth.createUserWithEmailAndPassword(emailAddress, password);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> login(
      String emailAddress, String password) async {
    try {
      final res =
          await fireAuth.loginWithEmailAndPassword(emailAddress, password);
      return Right(res);
    } on FirebaseAuthException catch (e) {
      return left(ServerFailure(e.toString()));
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
