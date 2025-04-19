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
    context.read<HomeCubit>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is GetAllConversationsLoadingState) {
          return ConversationLoading();
        } else if (state is GetAllConversationsErrorState) {
          return Center(child: Text(state.error));
        } else if (state is GetAllConversationsSuccessState) {
          if (state.AllConversations.isEmpty) {
            return EmptyChatWidget();
          }
          return GetAllConversationItem(conversations: state.AllConversations);
        }
        return Center(child: Text('No conversations available.'));
      },
    );
  }
}
