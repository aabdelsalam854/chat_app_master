// import 'dart:developer';

// import 'package:chat_master/core/error/failure.dart';
// import 'package:chat_master/core/services/firebase_auth_services.dart';
// import 'package:chat_master/features/auth/data/datasources/auth_remot.dart';
// import 'package:chat_master/features/auth/data/models/login_response.dart';
// import 'package:chat_master/features/auth/data/models/register_model.dart';
// import 'package:chat_master/features/auth/domain/repositories/auth_repo.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// import '../models/register_with_fire_base.dart';

// class AuthRepositoryImpl implements AuthRepository {
//   final AuthRemoteDataSource dataSource;
//   final FirebaseAuthServices firebaseAuthServices;

//   AuthRepositoryImpl(this.dataSource, this.firebaseAuthServices);
//   @override
//   Future<Either<Failure, LoginResponse>> login(
//       String email, String password) async {
//     try {
//       final response = await dataSource.login(email, password);
//       return Right(response);
//     } on DioException catch (e) {
//       return Left(ServerFailure(e.toString()));
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> register(RegisterModel registerModel) async {
//     try {
//       final response = await dataSource.register(registerModel);
//       return Right(response);
//     } on DioException catch (e) {
//       return Left(ServerFailure(e.toString()));
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> loginWithFacebook() async {
//     try {
//       final User user = await firebaseAuthServices.loginWithFacebook();

//       var idToken = await user.getIdToken();

//       final response = await dataSource.loginWithFirebase(idToken!);
//       return Right(response);
//     } on FirebaseAuthException catch (e) {
//       log(e.toString());
//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } on DioException catch (e) {
//        log(e.toString());
//       firebaseAuthServices.logout();

//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } catch (e) {
      
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> loginWithGoogle() async {
//     try {
//       final User user = await firebaseAuthServices.loginWithGoogle();

//       var idToken = await user.getIdToken();

//       final response = await dataSource.loginWithFirebase(idToken!);
//       return Right(response);
//     } on FirebaseAuthException catch (e) {
//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } on DioException catch (e) {
//       firebaseAuthServices.logout();

//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> registerWithFacebook(
//       RegisterWithFireBase userRequest) async {
//     try {
//       // final User user = await firebaseAuthServices.loginWithFacebook();
//       final User user = await firebaseAuthServices.loginWithFacebook();
//       final userRequest = RegisterWithFireBase(
//         email: user.email ?? "",
//         firebaseUid: user.uid,
//       );

//       final response = await dataSource.registerWithFirebase(userRequest);


//       return Right(response);
//     } on FirebaseAuthException catch (e) {
//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } on DioException catch (e) {
//       final failure = ServerFailure(e.toString());
//       return Left(failure);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> registerWithGoogle(
//       RegisterWithFireBase userRequest) async {
//     try {
//       // final response = await dataSource.registerWithFirebase(userRequest);
    

//       return Right(response);
//     } on DioException catch (e) {
//       if (e.response!.statusCode == 400) {
//         final failure = ServerFailure("User already exist");
//         return Left(failure);
//       }

//       final failure = ServerFailure(e.response?.data['msg']);
//       return Left(failure);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, dynamic>> signout() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, dynamic>> loginWithTwitter() async {
//     throw UnimplementedError();
//   }

//   @override
//   Future<Either<Failure, dynamic>> registerWithTwitter() {
//     // TODO: implement registerWithTwitter
//     throw UnimplementedError();
//   }
// }
