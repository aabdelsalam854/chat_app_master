import 'dart:async';

import 'package:chat_master/features/login/data/repo/login_and_register_repo.dart';
import 'package:chat_master/features/login/presentation/manger/cubit/login_and_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginAndRegisterCubit extends Cubit<LoginAndRegisterState> {
  LoginAndRegisterCubit(this.loginAndRegisterRepo) : super(LoginInitialState());
  final LoginAndRegisterRepo loginAndRegisterRepo;
  Future<void> registerInFireBase(
    String emailAddress,
    String password,
  ) async {
    emit(RegisterLoadingState());
    var request = await loginAndRegisterRepo.register(emailAddress, password);
    emit(request.fold((failure) => RegisterFailureState(failure.message),
        (register) => RegisterSuccessState(register)));
  }

  Future<void> loginInFireBase(
    String emailAddress,
    String password,
  ) async {
    emit(LoginLoadingState());
    var request = await loginAndRegisterRepo.login(emailAddress, password);
    emit(request.fold((failure) => LoginFailureState(failure.message),
        (login) => LoginSuccessState(login)));
  }

  bool showPassword = true;
  IconData suffix = Icons.visibility;
  changeShowPassword() {
    showPassword = !showPassword;
    suffix = showPassword ? Icons.visibility_off_outlined : Icons.visibility;
    emit(ChangeShowPasswordState());
  }
}
