import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_master/features/call/presentation/pages/call_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

AppBar chatsAppBar(BuildContext context, {String? name, String? image}) {
  return AppBar(
    backgroundColor: Colors.grey,
    leading: IconButton(
      icon: const Icon(
        CupertinoIcons.back,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    title: GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: image == null
                ? Image.asset("assets/images/facebook.png",
                    width: 40, height: 40, fit: BoxFit.cover)
                : CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/facebook.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Icon(
            CupertinoIcons.phone,
            size: 20,
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const NormalCallPage
                  (),
                ),
              );
            },
            child: const Icon(
              CupertinoIcons.video_camera_solid,
              size: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
