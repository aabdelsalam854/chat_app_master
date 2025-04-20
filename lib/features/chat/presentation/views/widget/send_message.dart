import 'dart:developer';

import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/fire_cloud/fire_cloud.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';

import 'package:flutter/material.dart';

@immutable
class SendMeaasge extends StatelessWidget {
  const SendMeaasge({
    super.key,
    this.controller,
    required this.email,
    required this.type,
    required this.message,
    required this.metadata,
  });
  final TextEditingController? controller;
  final String email;
  final String type;
  final String message;
  final MetadataModel? metadata;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        log(email);
        log(kUid);

        ChatService().sendMessage(
            kUid,
            email,
            MessageModel(
              message: controller!.text,
              id: email,
              type: type,
              metadata: null,
              time: DateTime.now(),
            ),
            UserModel(
              email: kUid,
              name: "kName",
              photoUrl: "kPhotoUrl",
              id: kUid,
            ),
            UserModel(
              email: email,
              name: "kName",
              photoUrl: "kPhotoUrl",
              id: email,
            ));

        // await FireCloud.sendMessage(MessageModel(
        //   message: message,
        //   id: email,
        //   type: type,
        //   metadata: null,
        //   time: DateTime.now(),
        // ));
        if (controller != null) {
          controller!.clear();
        } else {
          null;
        }
      },
      icon: const Icon(Icons.send),
    );
  }
}
