
import 'package:chat_master/core/widget/custom_circle_network_image.dart';
import 'package:chat_master/features/stories/presentation/pages/stories.dart';
import 'package:flutter/material.dart';

class StoryItem extends StatelessWidget {
  final Story story;

  const StoryItem({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 54,
        height: 54,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: CustomCircleNetworkImage(imageUrl: story.imageUrl),
      ),
      title: Text(
        story.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(story.time),
      onTap: () {
        // Navigate to story screen
      },
    );
  }
}

