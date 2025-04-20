import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/model/user_model.dart';

class Conversation {
  final String lastMessage;
  final String lastMessageTime;
  final Participants participants;
  final List<dynamic> userIds;

  Conversation(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.participants,
      required this.userIds});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        lastMessage: json['lastMessage'],
        lastMessageTime: parseTime(json['lastMessageTime'].toDate().toString()),
        participants: Participants.fromJson(json['participants']),
        userIds: json['users'],
      );

  Map<String, dynamic> toJson() => {
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
        'participants': participants.toJson(),
        'users': userIds,
      };
}

class Participants {
  final UserModel sender;
  final UserModel receiver;

  Participants({required this.sender, required this.receiver});

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']));
  Map<String, dynamic> toJson() => {
        'sender': sender.toJson(),
        'receiver': receiver.toJson(),
      };
}
