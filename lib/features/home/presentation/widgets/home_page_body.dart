import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/styles/cubit/theme_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<ThemeCubit>().changeTheme();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('chat master'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ChatTile(
              username: 'User $index',
              lastMessage: 'Last message from user $index',
              time: '${index + 1} min ago',
              onTap: () {
                // snackBar(context, 'Hello', Colors.red);
                GoRouter.of(context).push(Routes.kChatView, extra: "aasdasd");
              },
            );
          },
        ));
  }
}
