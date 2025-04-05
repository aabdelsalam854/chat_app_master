import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePageBody();
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action to perform when the button is pressed
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: Text('chat master'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ChatTile(
              username: 'User $index',
              lastMessage: 'Last message from user $index',
              time: '${index + 1} min ago',
              onTap: () {
                // Action to perform when the tile is tapped
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped on User $index')),
                );
              },
            );
          },
        ));
  }
}

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
