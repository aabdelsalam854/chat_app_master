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
      (failure) => emit(AuthLoginFailureState(failure.msg)),
      (user) => emit(AuthLoginSuccessState(user)),
    );
  }
  void register(RegisterModel registerModel ) async {
    emit(AuthRegisterLoadingState());
    final result = await authUseCases.register(registerModel );
    result.fold(
      (failure) => emit(AuthRegisterFailureState(failure.msg)),
      (user) => emit(AuthRegisterSuccessState(user)),
    );
  }


  void forgetPassword(String email) async {
    emit(AuthResetPasswordLoadingState());
    final result = await authUseCases.resetPassword(email);
    result.fold(
      (failure) => emit(AuthResetPasswordFailureState(failure.msg)),
      (message) => emit(const AuthResetPasswordSuccessState()),
    );
  }


}
