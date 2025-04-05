import 'package:bloc/bloc.dart';
import 'package:chat_master/features/auth/data/models/register_model.dart';
import 'package:chat_master/features/auth/domain/entities/user_entity.dart';
import 'package:chat_master/features/auth/domain/usecases/auth.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authUseCases) : super(AuthInitial());

final AuthUseCases authUseCases;

  void login(String email, String password) async {
    emit(AuthLoginLoadingState());
    final result = await authUseCases.login(email, password);
    result.fold(
      (failure) => emit(AuthLoginFailureState(failure.message)),
      (user) => emit(AuthLoginSuccessState(user)),
    );
  }
  void register(String email, String password, String covariantPassword) async {
    emit(AuthRegisterLoadingState());
    final result = await authUseCases.register(RegisterModel (
      email: email,
      password: password,
      covariantPassword: covariantPassword,
    ));
    result.fold(
      (failure) => emit(AuthRegisterFailureState(failure.message)),
      (user) => emit(AuthRegisterSuccessState(user)),
    );
  }


}
