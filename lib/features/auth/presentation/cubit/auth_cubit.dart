import 'package:bloc/bloc.dart';
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


}
