
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';

class GetAllConversationItem extends StatelessWidget {
  const GetAllConversationItem({
    super.key,
    required this.conversations,
  });

  final List<Conversation> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversationsData = conversations[index];
        return ChatTile(
          imgUrl: conversationsData.participants.receiver.photoUrl ?? "",
          username: conversationsData.participants.receiver.name,
          lastMessage: conversationsData.lastMessage,
          time: conversationsData.lastMessageTime,
          onTap: () {},
        );
      },
    );
  }
}
