import 'package:chat_master/core/error/failure.dart';
import 'package:chat_master/features/auth/domain/entities/user_entity.dart';
import 'package:chat_master/features/auth/domain/repositories/auth_repo.dart';
import 'package:dartz/dartz.dart';


class AuthUseCases {
  final AuthRepository authRepository;
  AuthUseCases(this.authRepository);

//*-----------------login------------------*//
  Future<Either<Failure, UserEntity>> login(
          String email, String password) async =>
      await authRepository.login(email, password);
//   //*-----------------register------------------*//
//   Future<Either<Failure, dynamic>> register(
//           RegisterModel registerModel) async =>
//       await authRepository.register(registerModel);

//   Future<Either<Failure, dynamic>> signout() async =>
//       await authRepository.signout();
//   //*----------- registerWithGoogle------------------*//
//   Future<Either<Failure, dynamic>> registerWithGoogle(
//           RegisterWithFireBase userRequest) async =>
//       await authRepository.registerWithGoogle(userRequest);
// //*----------- registerWithFacebook------------------*//
//   Future<Either<Failure, dynamic>> registerWithFacebook(
//           RegisterWithFireBase userRequest) async =>
//       await authRepository.registerWithFacebook(userRequest);
// //*----------- registerWithTwitter------------------*//
//   Future<Either<Failure, dynamic>> registerWithTwitter() async =>
//       await authRepository.registerWithTwitter();

// //*------------- loginWithFacebook------------------*//
//   Future<Either<Failure, dynamic>> loginWithFacebook() async =>
//       await authRepository.loginWithFacebook();
// //*----------------- loginWithGoogle------------------*//
//   Future<Either<Failure, dynamic>> loginWithGoogle() async =>
//       await authRepository.loginWithGoogle();
// //*----------------- loginWithTwitter------------------*//
//   Future<Either<Failure, dynamic>> loginWithTwitter() async =>
//       await authRepository.loginWithTwitter();
}
