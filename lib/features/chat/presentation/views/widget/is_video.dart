import 'package:chat_master/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class IsVideo extends StatelessWidget {
  const IsVideo({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.video_camera_front),
      onPressed: () {
        GoRouter.of(context).push(Routes.kVideoPlayer,
            extra: ({'message': message, 'isFile': false}));
      },
    );
  }
}
