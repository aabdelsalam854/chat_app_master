import 'package:chat_master/core/extensions/size.dart';
import 'package:chat_master/core/widget/custom_circle_network_image.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String username;
  final String lastMessage;
  final String time;
  final String imgUrl;
  final VoidCallback? onTap;

  const ChatTile({
    super.key,
    required this.username,
    required this.lastMessage,
    required this.time,
    this.onTap,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: GestureDetector(
        onTap: () {},
        child: CustomCircleNetworkImage(imageUrl: imgUrl),
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
      // trailing: Text(
      //   time,
      //   style: TextStyle(fontSize: 16, color: Colors.grey),
      // ),
    );
  }
}
