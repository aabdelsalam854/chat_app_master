
import 'package:chat_master/features/chat/presentation/views/widget/build_message_type_widget.dart';
import 'package:flutter/material.dart';

import '../../../data/model/messages_model.dart';


class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
    required this.messageModel,
  });

  final String message;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding:
            const EdgeInsets.only(bottom: 16, top: 16, left: 16, right: 16),
        decoration: const BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
            bottomLeft: Radius.circular(0),
           
          ),
         
        ),
        child: SizedBox(
          child:  BuildMessageTypeWidget(messageModel: messageModel, message: message),
        ),
      ),
    );
  }

}
