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
    required this.uid,
    required this.isGroup,
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
                  return ChatBubbleBuilder(
                    messageModel: messagesList[index],
                    kUid: uid,
                  );
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
// import 'package:chat_master/features/chat/presentation/widget/build_message_type_widget.dart';
// import 'package:flutter/material.dart';

// import '../../data/model/messages_model.dart';

// class ChatBubble extends StatelessWidget {
//   const ChatBubble({
//     super.key,
//     required this.message,
//     required this.messageModel,
//   });

//   final String message;
//   final MessageModel messageModel;

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           const SizedBox(width: 8),
//           const SizedBox(height: 8),
//           Flexible(
//             child: Container(
//               margin: const EdgeInsets.only(top: 5),
//               padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF20A090),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(0),
//                   topRight: Radius.circular(32),
//                   bottomLeft: Radius.circular(32),
//                   bottomRight: Radius.circular(32),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "userName",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   BuildMessageTypeWidget(
//                     messageModel: messageModel,
//                     message: message,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const CircleAvatar(
//             radius: 18,
//             backgroundColor: Color(0xFFEFEFEF),
//           ),
//         ],
//       ),
//     );
//   }
// }

class ChatBubbleBuilder extends StatelessWidget {
  const ChatBubbleBuilder({
    super.key,
    required this.messageModel,
    required this.kUid,
  });

  final MessageModel messageModel;
  final String kUid;

  @override
  Widget build(BuildContext context) {
    if (messageModel.id == kUid) {
      return ChatBubble(
        message: messageModel.message,
        messageModel: messageModel,
      );
    } else {
      return ChatBubbleFriend(
        message: messageModel.message,
        messageModel: messageModel,
      );
    }
  }
}
