import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/conversation_loading.dart';
import 'package:chat_master/features/home/presentation/widgets/empty_chat_widget.dart';
import 'package:chat_master/features/home/presentation/widgets/get_all_conversation_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    context.read<HomeCubit>().getAllConversations();
    super.initState();
  }

  @override
  void dispose() {
    // context.read<HomeCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
          current is GetAllConversationsLoadingState ||
          current is GetAllConversationsErrorState ||
          current is GetAllConversationsSuccessState,
      builder: (context, state) {

        if (state is GetAllConversationsLoadingState) {
          return const ConversationLoading();
        } else if (state is GetAllConversationsErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GetAllConversationsSuccessState) {
          if (state.allConversations.isEmpty) {
            return const EmptyChatWidget();
          }
          return GetAllConversationItem(conversations: state.allConversations);
        }
        return const Center(child: Text('No conversations available.'));
      },
    );
  }
}
