import 'package:chat_master/core/error/failure.dart';
import 'package:chat_master/features/auth/data/models/login_response.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/data/models/register_with_fire_base.dart';
import 'package:dartz/dartz.dart';


abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(String email, String password);
  Future<Either<Failure, dynamic>> register(RegisterModel registerModel);
  Future<Either<Failure, dynamic>> signout();

  Future<Either<Failure, dynamic>> registerWithGoogle(
      RegisterWithFireBase userRequest);

  Future<Either<Failure, dynamic>> registerWithFacebook( RegisterWithFireBase userRequest);

  Future<Either<Failure, dynamic>> registerWithTwitter();

  Future<Either<Failure, dynamic>> loginWithFacebook();

  Future<Either<Failure, dynamic>> loginWithGoogle();

  Future<Either<Failure, dynamic>> loginWithTwitter();
}
