import 'dart:io';

import 'package:chat_master/core/fire_cloud/fire_cloud.dart';
import 'package:chat_master/core/utils/upload_file_in_firebase.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/features/chat/data/model/messages_model.dart';
import 'package:chat_master/features/chat/data/model/metadata_model.dart';
import 'package:chat_master/features/chat/presentation/widget/video_player.dart';
import 'package:flutter/material.dart';

class ShowSend extends StatelessWidget {
  @override
  const ShowSend({super.key, this.videoUrl, required this.email});
  final dynamic videoUrl;
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: VideoView(
              local: true,
              videoUrl: videoUrl,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: CustomButton(
              text: 'Send',
              onPressed: () async {
                Navigator.pop(context);

                final upDateurl =
                    await UploadFileInFirebase.uploadFile(File(videoUrl.path));
                // await FireCloud.sendMessage(
                //   MessageModel(
                //       message: upDateurl,
                //       id: email,
                //       type: 'MessageType.video',
                //       time: DateTime.now(),
                //       metadata: MetadataModel(
                //         details: null,
                //         fileType: null,
                //         fileName: 'mp4',
                //         fileSize: null,
                //         width: 5,
                //         height: 5,
                //       )),
                // );
              },
            ),
          )
        ],
      ),
    );
  }
}
