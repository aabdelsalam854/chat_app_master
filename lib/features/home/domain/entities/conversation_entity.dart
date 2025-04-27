import 'package:chat_master/features/home/data/models/participants.dart';

import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  final String lastMessage;
  final DateTime lastMessageTime;
  final String lastMessageType;
  final Participants participants;
  final List<dynamic> userIds;

  const ConversationEntity(
      {required this.lastMessage,
      required this.lastMessageTime,
      required this.participants,
      required this.lastMessageType,
      required this.userIds});

  @override
  List<Object?> get props =>
      [lastMessage, lastMessageTime, participants, userIds, lastMessageType];
}
