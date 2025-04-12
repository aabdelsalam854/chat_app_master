import 'package:chat_master/core/extensions/size.dart';
import 'package:chat_master/core/widget/custom_circle_network_image.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String username;
  final String lastMessage;
  final String time;
  final VoidCallback? onTap;

  const ChatTile({
    super.key,
    required this.username,
    required this.lastMessage,
    required this.time,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: GestureDetector(
        onTap: () {
          print("object");
        },
        child: CustomCircleNetworkImage(
            imageUrl:
                'https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
      ), // Placeholder for the image URL
      title: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        username,
        style: TextStyle(
          fontSize: 2.h,
          fontWeight: FontWeight.bold,
          fontFamily: "IBMPlexSans",
        ),
      ),
      subtitle: Text(
        lastMessage,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
      trailing: Text(
        time,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
