import 'package:cached_network_image/cached_network_image.dart';
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
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: story.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child:
                  const Center(child: Icon(Icons.image, color: Colors.white)),
            ),
            errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
          ),
        ),
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
