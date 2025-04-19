import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/home_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: sl<HomeCubit>()..getAllConversations(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              GoRouter.of(context).push(Routes.kStartChat);
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Chat Master'),
            actions: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).push(Routes.kSettings);
                },
                icon: const Icon(Icons.more_vert_sharp),
              ),
            ],
          ),
          body: const HomePageBody(),
        ));
  }
}
