import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CustomCircleNetworkImage extends StatelessWidget {
  const CustomCircleNetworkImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(

      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 30,
          backgroundColor: Colors.transparent,
          backgroundImage: imageProvider,
      
        ),
        placeholder: (context, url) => Container(
          color: Colors.grey[300],
          width: 60,
          height: 60,
          child: const Center(child: Icon(Icons.image, color: Colors.white)),
        ),
        errorWidget: (context, url, error) =>
            const Icon(Icons.error, color: Colors.red),
      ),
    );
  }
}
