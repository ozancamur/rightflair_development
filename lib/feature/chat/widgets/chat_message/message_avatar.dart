import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class MessageAvatar extends StatelessWidget {
  final bool isNextMessageSameSender;
  final String? profilePhotoUrl;
  const MessageAvatar({
    super.key,
    required this.isNextMessageSameSender,
    this.profilePhotoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return isNextMessageSameSender
        ? SizedBox(width: context.width * 0.08)
        : (profilePhotoUrl != null && profilePhotoUrl!.isNotEmpty)
        ? CircleAvatar(
            radius: context.width * 0.04,
            backgroundImage: CachedNetworkImageProvider(profilePhotoUrl!),
          )
        : CircleAvatar(
            radius: context.width * 0.04,
            backgroundColor: context.colors.primary.withOpacity(0.2),
            child: Icon(
              Icons.person,
              size: context.width * 0.045,
              color: context.colors.primary,
            ),
          );
  }
}
