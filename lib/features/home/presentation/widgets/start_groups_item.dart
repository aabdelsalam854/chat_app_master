import 'package:chat_master/core/constant/constant.dart';
import 'package:chat_master/core/model/user_model.dart';
import 'package:chat_master/core/services/server_locator.dart';
import 'package:chat_master/core/widget/custom_button.dart';
import 'package:chat_master/features/home/data/models/group_conversation.dart';
import 'package:chat_master/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupsItem extends StatelessWidget {
  const GroupsItem({super.key, required this.users});
  final List<UserModel> users;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<Set<String>> selectedUsers = ValueNotifier({});

    return ValueListenableBuilder<Set<String>>(
      valueListenable: selectedUsers,
      builder: (context, selected, _) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  final isSelected = selected.contains(user.id);
                  return UserItem(
                    user: user,
                    isSelected: isSelected,
                    onTap: () => _toggleSelection(user, selectedUsers),
                  );
                },
              ),
            ),
            Visibility(
              visible: selected.isNotEmpty,
              replacement: const SizedBox.shrink(),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: CustomButton(
                  onPressed: () {
                    showCreateGroupDialog(context, (s) {}, selected);
                  },
                  text: "إنشاء الجروب",
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void _toggleSelection(UserModel user, ValueNotifier<Set<String>> notifier) {
    final selectedSet = notifier.value;

    if (selectedSet.contains(user.id)) {
      selectedSet.remove(user.id);
    } else {
      selectedSet.add(user.id);
    }

    notifier.value = Set.from(selectedSet);
  }
}

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  final UserModel user;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ChatTile(
            imgUrl: user.photoUrl ?? "",
            username: user.name,
            lastMessage: user.status ?? "",
            time: '1 min ago',
          ),
        ),
        Checkbox(
          value: isSelected,
          shape: const CircleBorder(),
          onChanged: (_) => onTap(),
        ),
      ],
    );
  }
}

void showCreateGroupDialog(BuildContext context,
    void Function(String groupName) onCreate, Set<String> userIds) {
  final TextEditingController groupNameController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("إنشاء جروب"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: const AssetImage('assets/group_default.png'),
            child: Icon(Icons.group,
                size: 40, color: Colors.white.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: groupNameController,
            decoration: const InputDecoration(
              labelText: 'اسم الجروب',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is CreateGroupConversationSuccessState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: const Text("تم إنشاء الجروب بنجاح"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("حسنا"),
                    ),
                  ],
                ),
              );
            } else if (state is CreateGroupConversationErrorState) {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(state.error),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("حسنا"),
                    ),
                  ],
                ),
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: () {
                final groupName = groupNameController.text.trim();
                if (groupName.isNotEmpty) {
                  Navigator.pop(context);
                  onCreate(groupName);
                  sl<HomeCubit>().createGroup(
                      groupConversation: GroupConversation(
                    null,
                    groupName: groupName,
                    lastMessage: "",
                    lastMessageTime: DateTime.now(),
                    senderName: "",
                    lastMessageType: "text",
                    userIds: [...userIds, kUid],
                  ));
                }
              },
              child: const Text('إنشاء'),
            );
          },
        ),
      ],
    ),
  );
}
