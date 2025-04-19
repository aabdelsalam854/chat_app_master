import 'package:chat_master/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyChatWidget extends StatelessWidget {
  const EmptyChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () {
        GoRouter.of(context).push(Routes.kStartChat);
      },
      child: const Text("Let's Start Chatting"),
    ));
  }
}
