import 'package:chat_master/features/home/presentation/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ConversationLoading extends StatelessWidget {
  const ConversationLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            imgUrl: "",
            username: 'User $index',
            lastMessage: 'Last message from user $index',
            time: '${index + 1} min ago',
            onTap: () {
              
            },
          );
        },
      ),
    );
  }
}
