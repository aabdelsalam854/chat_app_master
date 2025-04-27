import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/add_group.dart';
import 'package:chat_master/features/home/presentation/widgets/groups_view_body.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GroupsPage extends StatelessWidget {
  const GroupsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: sl<HomeCubit>()..getAllGroupConversations(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<HomeCubit>()..getUsers(),
                      child: const AddGroup(),
                    ),
                  ));
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text('Groups'),
            actions: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).push(Routes.kSettings);
                },
                icon: const Icon(Icons.more_vert_sharp),
              ),
            ],
          ),
          body: const GroupsViewBody(),
        ));
  }
}
