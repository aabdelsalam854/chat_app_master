import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginAndRegisterState {}

final class LoginInitialState extends LoginAndRegisterState {}

final class LoginLoadingState extends LoginAndRegisterState {}

final class LoginFailureState extends LoginAndRegisterState {
  final String errMessage;

  LoginFailureState(this.errMessage);
}

final class LoginSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  LoginSuccessState(this.credential);
}

final class RegisterLoadingState extends LoginAndRegisterState {}

final class RegisterFailureState extends LoginAndRegisterState {
  final String errMessage;

  RegisterFailureState(this.errMessage);
}

final class RegisterSuccessState extends LoginAndRegisterState {
  final UserCredential credential;

  RegisterSuccessState(this.credential);
}

final class ChangeShowPasswordState extends LoginAndRegisterState {}
