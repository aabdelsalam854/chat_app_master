import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_app_bar.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatefulWidget {
  final String email;
  final String uid;
  final String? name;
  final String? photoUrl;

  const ChatView(
      {super.key,
      required this.email,
      required this.uid,
      this.name,
      this.photoUrl});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController textController = TextEditingController();

  final controller = ScrollController();

  @override
  @override
  void dispose() {
    textController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: chatsAppBar(
          context,
          image: widget.photoUrl,
          name: widget.name,
        ),
        body: BlocProvider(
          create: (context) =>
              sl<ChatCubit>()..getMessages(userId1: kUid, userId2: widget.uid),
          child: ChatBody(
              widget: widget,
              controller: controller,
              textController: textController),
        ));
  }
}
