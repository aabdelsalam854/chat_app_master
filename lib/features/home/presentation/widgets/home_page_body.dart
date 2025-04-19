import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:chat_master/features/home/presentation/widgets/conversation_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).push(Routes.kStartChat);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Chat Master'),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(Routes.kSettings);
            },
            icon: const Icon(Icons.more_vert_sharp),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is GetAllConversationsLoadingState) {
            return ConversationLoading();
          } else if (state is GetAllConversationsErrorState) {
            return Center(child: Text(state.error));
          } else if (state is GetAllConversationsSuccessState) {
            final conversations = state.AllConversations;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final conversationsData = conversations[index];
                return ChatTile(
                  imgUrl:
                      conversationsData.participants.receiver.photoUrl ?? "",
                  username: conversationsData.participants.receiver.name,
                  lastMessage: conversationsData.lastMessage,
                  time: conversationsData.lastMessageTime,
                  onTap: () {},
                );
              },
            );
          }
          return Center(child: Text('No conversations available.'));
        },
      ),
    );
  }
}
