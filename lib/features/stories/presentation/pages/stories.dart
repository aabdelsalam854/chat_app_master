import 'package:chat_master/features/stories/presentation/widgets/story_item.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class Story {
  final String name;
  final String time;
  final String imageUrl;

  const Story({required this.name, required this.time, required this.imageUrl});
}

class StatusScreen extends StatelessWidget {
  final List<Story> stories = const [
    Story(
        name: "Nipun Srivastava",
        time: "8 minutes ago",
        imageUrl:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Story(
        name: "Keerthana SID",
        time: "10 minutes ago",
        imageUrl:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Story(
        name: "Ashima",
        time: "26 minutes ago",
        imageUrl:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Story(
        name: "Vijay Vanker",
        time: "Today, 22:26",
        imageUrl:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    Story(
        name: "Chinu",
        time: "Today, 21:29",
        imageUrl:
            "https://images.unsplash.com/photo-1575936123452-b67c3203c357?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
  ];

  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Status")),
      body: ListView.builder(
        itemCount: stories.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            // My Status
            return const ListTile(
              // leading: CircleAvatar(
              //   radius: 25,
              //   backgroundImage: AssetImage("assets/my_status.jpg"),
              // ),
              title: Text("My Status"),
              subtitle: Text("Tap to add status update"),
            );
          } else if (index == 1) {
            // Recent updates label
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                "Recent updates",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
            );
          } else {
            // Story items
            final story = stories[index - 2];
            return StoryItem(story: story);
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            mini: true,
            backgroundColor: Colors.grey[200],
            onPressed: () {},
            child: const Icon(Icons.edit, color: Colors.black),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}

class StoryViewer extends StatefulWidget {
  final List<Story> stories;
  final int initialIndex;

  const StoryViewer(
      {super.key, required this.stories, required this.initialIndex});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  late PageController _controller;
  late Timer _timer;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentIndex < widget.stories.length - 1) {
        _currentIndex++;
        _controller.animateToPage(_currentIndex,
            duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      } else {
        _timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.stories.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final story = widget.stories[index];
              return Center(
                child: Image.network(
                  story.imageUrl,
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: Text(
              widget.stories[_currentIndex].name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
