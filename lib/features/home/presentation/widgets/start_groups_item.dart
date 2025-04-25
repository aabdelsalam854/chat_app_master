import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/routes/routes.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StartGroupsItem extends StatelessWidget {
  const StartGroupsItem({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<UserModel>> selectedUsers = ValueNotifier([]);

    return ValueListenableBuilder<List<UserModel>>(
      valueListenable: selectedUsers,
      builder: (context, selected, _) {
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final isSelected = selected.contains(user);

            return Stack(
              children: [
                GestureDetector(
                  onTap: () => toggleSelection(user, selectedUsers),
                  child: ChatTile(
                    imgUrl: user.photoUrl ?? "",
                    username: user.name,
                    lastMessage: user.status ?? "",
                    time: '${index + 1} min ago',
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Checkbox(
                    value: isSelected,
                    shape: const CircleBorder(),
                    onChanged: (_) => toggleSelection(user, selectedUsers),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void toggleSelection(
      UserModel user, ValueNotifier<List<UserModel>> notifier) {
    final list = [...notifier.value];
    if (list.contains(user)) {
      list.remove(user);
    } else {
      list.add(user);
    }
    notifier.value = list;
  }
}
