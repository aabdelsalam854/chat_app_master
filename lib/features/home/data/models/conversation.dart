import 'package:chat_master/core/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageType;
  final Participants participants;
  final List<dynamic> userIds;

  Conversation(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.participants,
        required this.lastMessageType,
      required this.userIds});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        lastMessage: json['lastMessage'],
        lastMessageTime:
            (json['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        participants: Participants.fromJson(json['participants']),
        userIds: json['users'], 
        lastMessageType: json['lastMessageType'] ,
      );
}

class Participants {
  final UserModel sender;
  final UserModel receiver;

  Participants({required this.sender, required this.receiver});

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']));
}
