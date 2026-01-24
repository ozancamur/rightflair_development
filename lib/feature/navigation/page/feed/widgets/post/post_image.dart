import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/extensions/context.dart';

class PostImageWidget extends StatelessWidget {
  final String? url;
  const PostImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(context.width * 0.06),
        child: CachedNetworkImage(
          imageUrl:
              "https://images.unsplash.com/photo-1516826957135-700dedea698c?w=800",
          fit: BoxFit.cover,
          errorWidget: (context, url, error) =>
              Container(height: 100, width: 100, color: Colors.red),
        ),
      ),
    );
  }
}
