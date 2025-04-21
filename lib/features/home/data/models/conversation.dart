import 'package:chat_master/core/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation {
  final String lastMessage;
  final DateTime lastMessageTime;
  final Participants participants;
  final List<dynamic> userIds;

  Conversation(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.participants,
      required this.userIds});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        lastMessage: json['lastMessage'],
        lastMessageTime:
            (json['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        participants: Participants.fromJson(json['participants']),
        userIds: json['users'],
      );

  // Map<String, dynamic> toJson() => {
  //       'lastMessage': lastMessage,
  //       'lastMessageTime': lastMessageTime,
  //       'participants': participants.toJson(),
  //       'users': userIds,
  //     };
}

class Participants {
  final UserModel sender;
  final UserModel receiver;

  Participants({required this.sender, required this.receiver});

  factory Participants.fromJson(Map<String, dynamic> json) => Participants(
      sender: UserModel.fromJson(json['sender']),
      receiver: UserModel.fromJson(json['receiver']));
  // Map<String, dynamic> toJson() => {
  //       'sender': sender.toJson(),
  //       'receiver': receiver.toJson(),
  //     };
}


//  Conversation(
//           lastMessage: message.message,
//           lastMessageTime: message.time,
//           participants: Participants(
//             sender: user1,
//             receiver: user2,
//           ),
//           userIds: [user1.id, user2.id],
//         ).toJson(),
        