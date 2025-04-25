import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
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
                sl<ChatCubit>().sendFiles(
                  files: videoUrl,
                  description: "",
                  user1: UserModel(
                    email: kUid,
                    name: "kName",
                    photoUrl: "kPhotoUrl",
                    id: kUid,
                  ),
                  user2: const UserModel(
                    email: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                    name: "kName",
                    photoUrl: "kPhotoUrl",
                    id: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                  ),
                  userId1: kUid,
                  userId2: "ZBsU7iXYmaT46Xz58QXp1D8IDz02",
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
