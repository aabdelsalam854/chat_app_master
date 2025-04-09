import 'package:bloc/bloc.dart';
import 'package:chat_master/core/model/user_model.dart';

import 'package:chat_master/features/profile/domain/usecases/usecases.dart';
import 'package:equatable/equatable.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileUsecases) : super(ProfileInitial());
  final ProfileUsecases profileUsecases;

  Future<void> getUserData(String uid) async {
    emit(GetUserDataLoadingState());
    final response = await profileUsecases.getUserData(uid);
    response.fold(
      (failure) => emit(GetUserDataErrorState(failure.message)),
      (userModel) => emit(GetUserDataSuccessState(userModel)),
    );
  }
  Future<void> updateProfile(UserModel userModel) async {
    emit(UpdateProfileLoadingState());
    final response = await profileUsecases.updateProfile(userModel);
    response.fold(
      (failure) => emit(UpdateProfileErrorState(failure.message)),
      (userModel) => emit(UpdateProfileSuccessState(userModel)),
    );
  }
  Future<void> updatePassword(String password) async {
    emit(UpdatePasswordLoadingState());
    final response = await profileUsecases.updatePassword(password);
    response.fold(
      (failure) => emit(UpdatePasswordErrorState(failure.message)),
      (message) => emit(UpdatePasswordSuccessState(message)),
    );
  }
  

}
