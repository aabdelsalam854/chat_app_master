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
  final StreamController<List<Conversation>> _streamController =
      StreamController<List<Conversation>>.broadcast();
  Stream<List<Conversation>> get conversationsStream =>
      _streamController.stream;
  Future<void> getUsers() async {
    emit(GetUsersLoadingState());
    var data = await usecases.getUsers('7SQ43pgmTqTgBeVKiflmyzPl4wp1');
    data.fold(
      (failure) {
        emit(GetUsersErrorState(failure.msg));
      },
      (users) {
        emit(GetUsersSuccessState(users));
      },
    );
  }

  Future<void> getAllConversations() async {
    emit(GetAllConversationsLoadingState());

    var data = await usecases.getAllConversations();
    data.fold(
      (failure) {
        emit(GetAllConversationsErrorState(failure.msg));
      },
      (conversations) {
        _streamController.add(conversations);
        emit(GetAllConversationsSuccessState(conversations));
      },
    );
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }
}
