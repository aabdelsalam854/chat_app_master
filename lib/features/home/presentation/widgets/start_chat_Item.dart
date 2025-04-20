import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartChatItem extends StatelessWidget {
  const StartChatItem({
    super.key,
    required this.users,
  });
  final List<UserModel> users;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ChatTile(
          imgUrl: users[index].photoUrl ?? "",
          username: users[index].name,
          lastMessage: 'Last message from user $index',
          time: '${index + 1} min ago',
          onTap: () {
            // snackBar(context, 'Hello', Colors.red);
            GoRouter.of(context).pushReplacement(
              Routes.kChatView,
              extra: {
                'email': users[index].email,
                'name': users[index].name,
                'photoUrl': users[index].photoUrl,
                'id': users[index].id
              },
            );
          },
        );
      },
    );
  }
}
