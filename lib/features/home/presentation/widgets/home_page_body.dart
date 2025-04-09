import 'package:chat_master/core/routes/routes.dart';

import 'package:chat_master/features/app/presentation/cubits/app/app_cubit.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<AppCubit>().changeTheme();
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('chat master'),
          actions: [
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(Routes.kProfile);
              },
              icon: const Icon(Icons.more_vert_sharp),
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetUsersSuccessState) {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return ChatTile(
                    username: state.users[index].email,
                    lastMessage: 'Last message from user $index',
                    time: '${index + 1} min ago',
                    onTap: () {
                      // snackBar(context, 'Hello', Colors.red);
                      GoRouter.of(context)
                          .push(Routes.kChatView, extra: state.users[index].id);
                    },
                  );
                },
              );
            } else if (state is GetUsersErrorState) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Shimmer(
                gradient: const LinearGradient(
                  colors: [Colors.grey, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ChatTile(
                      username: 'User $index',
                      lastMessage: 'Last message from user $index',
                      time: '${index + 1} min ago',
                      onTap: () {
                        // snackBar(context, 'Hello', Colors.red);
                      },
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
