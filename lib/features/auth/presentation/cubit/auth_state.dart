part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final UserEntity user;

  const AuthLoginSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLoginFailureState extends AuthState {
  final String error;

  const AuthLoginFailureState(this.error);

  @override
  List<Object> get props => [error];
}

final class AuthRegisterLoadingState extends AuthState {}

final class AuthRegisterSuccessState extends AuthState {
  final UserEntity user;

  const AuthRegisterSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

final class AuthRegisterFailureState extends AuthState {
  final String error;

  const AuthRegisterFailureState(this.error);

  @override
  List<Object> get props => [error];
}


final class AuthResetPasswordLoadingState extends AuthState {}
final class AuthResetPasswordSuccessState extends AuthState {


  const AuthResetPasswordSuccessState();

  @override
  List<Object> get props => [];
}
final class AuthResetPasswordFailureState extends AuthState {
  final String error;

  const AuthResetPasswordFailureState(this.error);

  @override
  List<Object> get props => [error];
}
