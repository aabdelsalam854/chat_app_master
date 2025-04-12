

import 'package:chat_master/core/model/user_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}
class GetUserDataLoadingState extends ProfileState {}
class GetUserDataSuccessState extends ProfileState {
  final UserModel userModel;

  const GetUserDataSuccessState(this.userModel);
}
class GetUserDataErrorState extends ProfileState {
  final String error;

  const GetUserDataErrorState(this.error);
}
class UpdateProfileLoadingState extends ProfileState {}
class UpdateProfileSuccessState extends ProfileState {
  final UserModel userdata;

  const UpdateProfileSuccessState(this.userdata);
  @override
  List<Object> get props => [userdata];
}
class UpdateProfileErrorState extends ProfileState {
  final String error;

  const UpdateProfileErrorState(this.error);
}
class UpdatePasswordLoadingState extends ProfileState {}
class UpdatePasswordSuccessState extends ProfileState {
  final String message;

  const UpdatePasswordSuccessState(this.message);
}
class UpdatePasswordErrorState extends ProfileState {
  final String error;

  const UpdatePasswordErrorState(this.error);
}
