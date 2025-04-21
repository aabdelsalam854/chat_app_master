import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

        final isSender = conversationsData.participants.sender.id == kUid;
        final otherUser = isSender
            ? conversationsData.participants.receiver
            : conversationsData.participants.sender;
        return ChatTile(
          imgUrl: otherUser.photoUrl ?? "",
          username: otherUser.name,
          lastMessage: conversationsData.lastMessage,
          time: parseTime(
            conversationsData.lastMessageTime.toString(),
          ),
          onTap: () {
            // log(conversationsData.participants.sender.id);
            // log(otherUser.id);
            // log(kUid);
            GoRouter.of(context).push(
              Routes.kChatView,
              extra: {
                'email': otherUser.email,
                'name': otherUser.name,
                'photoUrl': otherUser.photoUrl,
                'id': otherUser.id,
              },
            );
          },
        );
      },
    );
  }
}
