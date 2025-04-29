import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_state.dart';

import 'package:chat_master/features/chat/presentation/widget/get_chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.controller,
    required this.textController,
    required this.email,
    required this.uid,
    required this.isGroup,
  });

  final ScrollController controller;
  final TextEditingController textController;
  final String email;
  final String uid;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is GetMessagesSuccessState ||
          current is GetMessagesLoadingState ||
          current is GetMessagesErrorState,
      builder: (context, state) {
        if (state is GetMessagesSuccessState) {
          final messagesList = state.messages;
          return GetChatItem(
              isGroup: isGroup,
              controller: controller,
              messagesList: messagesList,
              email: email,
              uid: uid,
              textController: textController);
        } else if (state is GetMessagesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMessagesErrorState) {
          return Center(child: Text('Error: ${state.msg}'));
        }
        return const SizedBox.shrink(); // Default case
      },
    );
  }
}
