import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:equatable/equatable.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class GetMessagesLoadingState extends ChatState {}

class GetMessagesSuccessState extends ChatState {
  final List<MessageModel> messages;
  const GetMessagesSuccessState(this.messages);

  @override
  List<Object> get props => [messages];
}

class GetMessagesErrorState extends ChatState {
  final String msg;
  const GetMessagesErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}

class SendMessageLoadingState extends ChatState {}

class SendMessageSuccessState extends ChatState {
  final bool send;
  const SendMessageSuccessState(this.send);

  @override
  List<Object> get props => [send];
}

class SendMessageErrorState extends ChatState {
  final String msg;
  const SendMessageErrorState(this.msg);

  @override
  List<Object> get props => [msg];
}
