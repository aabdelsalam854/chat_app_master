part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetUsersLoadingState extends HomeState {}

class GetUsersSuccessState extends HomeState {
  final List<UserModel> users;
  const GetUsersSuccessState(this.users);
  @override
  List<Object> get props => [users];
}

class GetUsersErrorState extends HomeState {
  final String error;
  const GetUsersErrorState(this.error);
  @override
  List<Object> get props => [error];
}

class GetAllConversationsLoadingState extends HomeState {}

class GetAllConversationsSuccessState extends HomeState {
  final List<Conversation> allConversations;
  const GetAllConversationsSuccessState(this.allConversations);
  @override
  List<Object> get props => [allConversations];
}

class GetAllConversationsErrorState extends HomeState {
  final String error;
  const GetAllConversationsErrorState(this.error);
  @override
  List<Object> get props => [error];
}


class GetAllGroupConversationsLoadingState extends HomeState {}
class GetAllGroupConversationsSuccessState extends HomeState {
  final List<GroupConversation> allGroupConversations;
  const GetAllGroupConversationsSuccessState(this.allGroupConversations);
  @override
  List<Object> get props => [allGroupConversations];
}
class GetAllGroupConversationsErrorState extends HomeState {
  final String error;
  const GetAllGroupConversationsErrorState(this.error);
  @override
  List<Object> get props => [error];
}
