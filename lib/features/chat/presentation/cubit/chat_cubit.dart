import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';

import 'package:chat_master/features/chat/domain/usecases/chat_usecase.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.usecases) : super(ChatInitial());
  final ChatUsecases usecases;
  StreamSubscription? _subscription;

  getMessages({required String userId1, required String userId2}) {
    emit(GetMessagesLoadingState());

    _subscription = usecases
        .getMessages(userId1: userId1, userId2: userId2)
        .listen((either) {
      either.fold(
        (failure) => emit(GetMessagesErrorState(failure.msg)),
        (messages) => emit(GetMessagesSuccessState(messages)),
      );
    });
  }

  sendMessage(
      {required String userId1,
      required String userId2,
      required MessageModel message,
      required UserModel user1,
      required UserModel user2}) {
    emit(SendMessageLoadingState());
    var result = usecases.sendMessage(
        userId1: userId1,
        userId2: userId2,
        message: message,
        user1: user1,
        user2: user2);
    result.then((value) {
      value.fold(
        (failure) => emit(SendMessageErrorState(failure.msg)),
        (send) => emit(const SendMessageSuccessState(true)),
      );
    });
  }

  Future<void> sendFiles({
    required List<File> files,
    required String description,
    required UserModel user1,
    required UserModel user2,
    required String userId1,
    required String userId2,
  }) async {
    emit(SendMessageLoadingState());
    var result = await usecases.sendFiles(
      files: files,
      description: description,
      user1: user1,
      user2: user2,
      userId1: userId1,
      userId2: userId2,
    );
    result.fold(
      (failure) => emit(SendMessageErrorState(failure.msg)),
      (send) => emit(const SendMessageSuccessState(true)),
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
