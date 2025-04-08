part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetUsersLoadingState extends HomeState{}
class GetUsersSuccessState extends HomeState{
  final List<UserModel> users;
  const GetUsersSuccessState(this.users);
  @override
  List<Object> get props => [users];
}
class GetUsersErrorState extends HomeState{
  final String error;
  const GetUsersErrorState(this.error);
  @override
  List<Object> get props => [error];
}
