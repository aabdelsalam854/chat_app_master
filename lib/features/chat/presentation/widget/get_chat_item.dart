import 'package:chat_master/core/widget/custom_text_form_field.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/presentation/pages/chat_views.dart';
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
    required this.widget,
    required this.textController,
  });

  final ScrollController controller;
  final List<MessageModel> messagesList;
  final ChatView widget;
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
                  return messagesList[index].id == widget.email
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
                    metadata: null,
                    type: 'MessageType.text',
                    message: textController.text,
                    controller: textController,
                    email: widget.uid),
                // isEmpty
                //     ? recorder(context)
                //     : SendMessage(
                //         metadata: null,
                //         type: 'MessageType.text',
                //         message: textController.text,
                //         controller: textController,
                //         email: widget.email),

                
                Expanded(
                  child: CustomTextFormField(
                    icon: IconButton(
                      onPressed: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) {
                            return MediaSelection(email: widget.email);
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
