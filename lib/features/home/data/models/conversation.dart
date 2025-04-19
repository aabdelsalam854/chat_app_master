import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/model/user_model.dart';

class Conversation {
  final String lastMessage;
  final String lastMessageTime;
  final Participants participants;

  Conversation(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.participants});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
      lastMessage: json['lastMessage'],
      lastMessageTime:parseDateTime( json['lastMessageTime'].toDate().toString()),
      participants: Participants.fromJson(json['participants']));
}



class Participants {
  final UserModel sender;
  final UserModel receiver;

  Participants({required this.sender, required this.receiver});

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']));
}
