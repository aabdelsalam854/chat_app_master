import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/conversation_loading.dart';
import 'package:chat_master/features/home/presentation/widgets/empty_chat_widget.dart';
import 'package:chat_master/features/home/presentation/widgets/get_all_conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsViewBody extends StatelessWidget {
  const GroupsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetAllGroupConversationsLoadingState ||
          current is GetAllGroupConversationsErrorState ||
          current is GetAllGroupConversationsSuccessState,
      builder: (context, state) {
        if (state is GetAllGroupConversationsLoadingState) {
          return const ConversationLoading();
        } else if (state is GetAllGroupConversationsErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GetAllGroupConversationsSuccessState) {
          if (state.allGroupConversations.isEmpty) {
            return const EmptyChatWidget();
          }
          return GetAllGroupConversationItem(
              conversations: state.allGroupConversations);
        }
        return const Center(child: Text('No conversations available.'));
      },
    );
  }
}
