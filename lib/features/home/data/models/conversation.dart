import 'package:chat_master/features/home/data/models/participants.dart';
import 'package:chat_master/features/home/domain/entities/conversation_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conversation extends ConversationEntity {
  const Conversation(
      {required super.lastMessage,
      required super.lastMessageTime,
      required super.participants,
      required super.lastMessageType,
      required super.userIds});

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        lastMessage: json['lastMessage'],
        lastMessageTime:
            (json['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        participants: Participants.fromJson(json['participants']),
        userIds: json['users'],
        lastMessageType: json['lastMessageType'],
      );
}
