import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/widget/app_bottom_sheet.dart';
import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';

import 'package:chat_master/features/chat/presentation/widget/chat_bubble.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_bubble_friend.dart';
import 'package:chat_master/features/chat/presentation/widget/media_selection.dart';
import 'package:chat_master/features/chat/presentation/widget/send_message.dart';
import 'package:flutter/material.dart';

class GetChatItem extends StatelessWidget {
  const GetChatItem({
    super.key,
    required this.controller,
    required this.messagesList,
    required this.textController,
    required this.email,
    required this.uid, required this.isGroup,
  });

  final ScrollController controller;
  final List<MessageModel> messagesList;
  final String email;
  final String uid;
  final bool isGroup;

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                controller: controller,
                itemBuilder: (context, index) {
                  return messagesList[index].id != kUid
                      ? ChatBubble(
                          messageModel: messagesList[index],
                          message: messagesList[index].message,
                        )
                      : ChatBubbleFriend(
                          message: messagesList[index].message,
                          messageModel: messagesList[index]);
                },
                itemCount: messagesList.length,
              ),
            ),
            Row(
              children: [
                SendMessage(
                  isGroup: isGroup,
                    metadata: null,
                    type: 'text',
                    message: textController.text,
                    controller: textController,
                    email: uid),
                Expanded(
                  child: CustomTextFormField(
                    icon: IconButton(
                      onPressed: () {
                        showAppBottomSheet(
                          enableDrag: true,
                          context,
                          builder: (context) {
                            return MediaSelection(email: email);
                          },
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                    controller: textController,
                    hintText: 'Type a message',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
