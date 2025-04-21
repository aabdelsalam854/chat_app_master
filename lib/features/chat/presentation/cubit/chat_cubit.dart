import 'dart:async';

import 'package:bloc/bloc.dart';

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

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
