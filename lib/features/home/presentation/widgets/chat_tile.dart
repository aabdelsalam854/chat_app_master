
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
      leading:
          CircleAvatar(radius: 30, child: Image.asset('assets/images/man.png')),
      title: Text(
        username,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
