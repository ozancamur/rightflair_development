import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/core/components/text/text.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../core/constants/route.dart';

class ChatAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? userPhoto;
  final String userId;

  const ChatAppBarWidget({
    super.key,
    required this.userName,
    this.userPhoto,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.colors.secondary,
      foregroundColor: context.colors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: _title(context),
    );
  }

  GestureDetector _title(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteConstants.USER, extra: userId),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: context.width * 0.03),
            child: CircleAvatar(
              radius: context.width * 0.045,
              backgroundColor: context.colors.primary.withOpacity(0.2),
              backgroundImage: userPhoto != null && userPhoto!.isNotEmpty
                  ? CachedNetworkImageProvider(userPhoto!)
                  : null,
              child: userPhoto == null || userPhoto!.isEmpty
                  ? Icon(
                      Icons.person,
                      size: context.width * 0.05,
                      color: context.colors.primary,
                    )
                  : null,
            ),
          ),
          Flexible(
            child: TextComponent(
              text: userName,
              size: FontSizeConstants.LARGE,
              weight: FontWeight.w600,
              color: context.colors.primary,
              overflow: TextOverflow.ellipsis,
              tr: false,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
