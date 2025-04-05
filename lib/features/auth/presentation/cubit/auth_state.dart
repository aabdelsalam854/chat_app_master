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

