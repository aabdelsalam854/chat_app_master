import 'package:cloud_firestore/cloud_firestore.dart';

class GroupConversation {
  final String groupName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageType;
  final String senderName;

  final List<dynamic> userIds;

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

  GroupConversation(
      {required this.groupName,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.lastMessageType,
      required this.senderName,
      required this.userIds});
  Map<String, dynamic> toJson() => {
        'groupName': groupName,
        'lastMessage': lastMessage,
        'lastMessageTime': lastMessageTime,
        'senderName': senderName,
        'lastMessageType': lastMessageType,
        'users': userIds,
      };
}
