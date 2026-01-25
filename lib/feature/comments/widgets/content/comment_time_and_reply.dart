import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/constants/string.dart';

import '../../../../core/components/text.dart';
import '../../../../core/extensions/context.dart';

class CommentTimeAndReplyWidget extends StatelessWidget {
  final DateTime createdAt;
  const CommentTimeAndReplyWidget({super.key, required this.createdAt});

  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays >= 365) {
      return '${(difference.inDays / 365).floor()}y';
    } else if (difference.inDays >= 7) {
      return '${(difference.inDays / 7).floor()}w';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays}d';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextComponent(
          text: timeAgo,
          color: context.colors.primary.withOpacity(0.5),
          size: FontSizeConstants.XX_SMALL,
          tr: false,
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () {
            // Handle reply
          },
          child: TextComponent(
            text: AppStrings.COMMENTS_REPLY,
            color: context.colors.primary.withOpacity(0.5),
            size: FontSizeConstants.XX_SMALL,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
