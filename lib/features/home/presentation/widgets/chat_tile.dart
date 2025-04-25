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
      ), 
      title: Row(
        children: [
          Expanded(
              flex: 4,
              child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  username,
                  style: TextStyle(
                      fontSize: 2.h,
                      fontWeight: FontWeight.bold,
                      fontFamily: "IBMPlexSans"))),
          Expanded(
              flex: 1,
              child: Text(time,
                  style: const TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold))),
        ],
      ),
      subtitle: Row(
        children: [
          Text(lastMessage,
              style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
      // trailing:
    );
  }
}
