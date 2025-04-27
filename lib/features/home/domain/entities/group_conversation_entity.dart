import 'package:equatable/equatable.dart';

class GroupConversationEntity extends Equatable {
  final String groupName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageType;
  final String senderName;

  final List<dynamic> userIds;

  const GroupConversationEntity(
      {required this.groupName,
      required this.lastMessage,
      required this.lastMessageTime,
      required this.lastMessageType,
      required this.senderName,
      required this.userIds});
  @override
  List<Object?> get props => [
        groupName,
        lastMessage,
        lastMessageTime,
        senderName,
        lastMessageType,
        userIds
      ];
}
