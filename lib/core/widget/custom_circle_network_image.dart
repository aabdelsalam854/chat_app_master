import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

class CustomCircleNetworkImage extends StatelessWidget {
  const CustomCircleNetworkImage({
    super.key,
    required this.imageUrl, this.radius,
  });

  final String imageUrl;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return ClipOval(

      child:imageUrl.isNotEmpty? CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,

        filterQuality: FilterQuality.high,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius:radius?? 30,
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
            Image.asset("assets/images/man.png"),
      ): Image.asset("assets/images/man.png"),
    );
  }
}
