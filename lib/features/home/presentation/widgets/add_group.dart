import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/conversation_loading.dart';
import 'package:chat_master/features/home/presentation/widgets/start_chat_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Select a user'),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetUsersSuccessState) {
              return StartChatItem(
                users: state.users,
              );
            } else if (state is GetUsersErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return const ConversationLoading();
            }
          },
        ));
  }
}
