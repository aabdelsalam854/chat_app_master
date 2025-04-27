import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_app_bar.dart';
import 'package:chat_master/features/chat/presentation/widget/chat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatGroupView extends StatefulWidget {
  final String photoUrl;

  final String groupId;
  final String groupName;
  final int groupMembersCount;

  const ChatGroupView({
    super.key,
    required this.photoUrl,
    required this.groupId,
    required this.groupName,
    required this.groupMembersCount,
  });

  @override
  State<ChatGroupView> createState() => _ChatGroupViewState();
}

class _ChatGroupViewState extends State<ChatGroupView> {
  final TextEditingController textController = TextEditingController();

  final controller = ScrollController();

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
          name: widget.groupName,
        ),
        body: BlocProvider(
            create: (context) =>
                sl<ChatCubit>()..getGroupMessages(groupId: widget.groupId),
            child: ChatBody(
              isGroup: true,
                email: kUid,
                uid: kUid,
                controller: controller,
                textController: textController)));
  }
}
