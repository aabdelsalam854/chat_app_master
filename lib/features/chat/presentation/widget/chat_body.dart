import 'package:chat_master/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_master/features/chat/presentation/cubit/chat_state.dart';
import 'package:chat_master/features/chat/presentation/pages/chat_views.dart';
import 'package:chat_master/features/chat/presentation/widget/get_chat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.widget,
    required this.controller,
    required this.textController,
  });

  final ChatView widget;
  final ScrollController controller;
  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is GetMessagesSuccessState) {
          final messagesList = state.messages;
          return GetChatItem(
              controller: controller,
              messagesList: messagesList,
              widget: widget,
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
