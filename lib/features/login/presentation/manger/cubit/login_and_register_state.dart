import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAndRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class LoginInitialState extends LoginAndRegisterState {}

final class LoginLoadingState extends LoginAndRegisterState {}

final class LoginFailureState extends LoginAndRegisterState {
  final String errMessage;

  LoginFailureState(this.errMessage);
  @override
  List<Object?> get props => [errMessage];
}

final class LoginSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  LoginSuccessState(this.credential);
  @override
  List<Object?> get props => [credential];
}

final class RegisterLoadingState extends LoginAndRegisterState {}

final class RegisterFailureState extends LoginAndRegisterState {
  final String errMessage;

  RegisterFailureState(this.errMessage);
  @override
  List<Object?> get props => [errMessage];
}

final class RegisterSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  RegisterSuccessState(this.credential);
  @override
  List<Object?> get props => [credential];
}

final class ChangeShowPasswordState extends LoginAndRegisterState {}
