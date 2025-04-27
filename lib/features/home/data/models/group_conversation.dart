import 'package:chat_master/features/home/domain/entities/group_conversation_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupConversation extends GroupConversationEntity {
  const GroupConversation(
      {required super.groupName,
      required super.lastMessage,
      required super.lastMessageTime,
      required super.lastMessageType,
      required super.senderName,
      required super.userIds});

  factory GroupConversation.fromJson(Map<String, dynamic> json) =>
      GroupConversation(
        groupName: json['groupName'] ?? "",
        lastMessage: json['lastMessage'] ?? "لم يتم إرسال أي رسائل بعد",
        lastMessageTime:
            (json['lastMessageTime'] as Timestamp?)?.toDate() ?? DateTime.now(),
        senderName: json['senderName'] ?? "",
        lastMessageType: json['lastMessageType'] ?? "",
        userIds: json['users'] ?? [].map<String>((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
        'senderName': senderName,
        'lastMessageType': lastMessageType,
        'users': userIds,
      };
}
