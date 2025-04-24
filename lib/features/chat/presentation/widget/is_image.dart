import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_master/core/routes/routes.dart';

import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IsImage extends StatelessWidget {
  const IsImage({
    super.key,
    required this.message,
    required this.messageModel,
  });
  final String message;
  final MessageModel messageModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
            onTap: () {
              GoRouter.of(context).push(Routes.kShowImage, extra: message);
            },
            child:CachedNetworkImage(imageUrl: message,
            )),
        const SizedBox(
          height: 2,
        ),
        Text(messageModel.time.toString())
      ],
    );
  }
}
