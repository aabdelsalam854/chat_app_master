import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/domain/usecases/messages.dart';
import 'package:equatable/equatable.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.usecases) : super(HomeInitial());
  final MessagesUsecases usecases;

  StreamSubscription? _subscription;
  Future<void> getUsers() async {
    emit(GetUsersLoadingState());
    var data = await usecases.getUsers();
    data.fold(
      (failure) {
        emit(GetUsersErrorState(failure.msg));
      },
      (users) {
        emit(GetUsersSuccessState(users));
      },
    );
  }

  getAllConversations() async {
    emit(GetAllConversationsLoadingState());
    _subscription = usecases.getAllConversations().listen((either) {
      either.fold(
        (failure) => emit(GetAllConversationsErrorState(failure.msg)),
        (conversations) => emit(GetAllConversationsSuccessState(conversations)),
      );
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
