import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/functions/functions.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/home/data/models/conversation.dart';
import 'package:chat_master/features/home/domain/entities/group_conversation_entity.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/navigation.dart';
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
          lastMessage: conversationsData.lastMessageType != "text"
              ? conversationsData.lastMessageType
              : conversationsData.lastMessage,
          time: parseTime(
            conversationsData.lastMessageTime.toString(),
          ),
          onTap: () {
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

class GetAllGroupConversationItem extends StatelessWidget {
  const GetAllGroupConversationItem({
    super.key,
    required this.conversations,
  });

  final List<GroupConversationEntity> conversations;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        final conversationsData = conversations[index];

        return ChatTile(
          imgUrl: "",
          username: conversationsData.groupName,
          lastMessage: conversationsData.lastMessageType != "text"
              ? conversationsData.lastMessageType
              : conversationsData.lastMessage.isEmpty
                  ? "لم يتم إرسال أي رسائل بعد"
                  : conversationsData.lastMessage,
          time: "",
          //  parseTime(
          //   conversationsData.lastMessageTime.toString(),
          // ),
          onTap: () {
            sl<HomeCubit>().close();

            GoRouter.of(context).push(
              Routes.kChatViewGroup,
              extra:

                  //  GroupChatExtras(
                  //   photoUrl: conversationsData.groupName,
                  //   groupId: conversationsData.docId!,
                  //   groupName: conversationsData.groupName,
                  //   groupMembersCount: conversations.length,
                  // ).toMap(),

                  {
                "photoUrl": conversationsData.groupName,
                "groupId": conversationsData.docId!,
                "groupName": conversationsData.groupName,
                "groupMembersCount": conversations.length,
              },
            );

            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return ChatGroupView(
            //     photoUrl: conversationsData.groupName,
            //     groupId: conversationsData.docId!,
            //     groupName: conversationsData.groupName,
            //     groupMembersCount: conversations.length,
            //   );
            // }));
          },
        );
      },
    );
  }
}
