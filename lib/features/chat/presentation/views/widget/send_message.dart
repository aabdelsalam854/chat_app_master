import 'dart:developer';

import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/model/user_model.dart';

import 'package:flutter/material.dart';

import '../../../../../core/fire_cloud/fire_cloud.dart';
import '../../../data/model/messages_model.dart';
import '../../../data/model/metadata_model.dart';

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
        log(controller!.text);
        log(message);
        log(MessageModel(
          message: message,
          id: email,
          type: type,
          metadata: metadata,
          time: DateTime.now(),
        ).toJson().toString());

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
              email: kUid,
              name: "kName",
              photoUrl: "kPhotoUrl",
              id: kUid,
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
