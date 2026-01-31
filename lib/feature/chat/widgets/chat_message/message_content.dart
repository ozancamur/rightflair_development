import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/components/text/text.dart';
import '../../../../core/constants/font/font_size.dart';
import '../../../../core/extensions/context.dart';

class MessageContentWidget extends StatelessWidget {
  final bool isOwnMessage;
  final String? imageUrl;
  final String? content;
  const MessageContentWidget({
    super.key,
    required this.isOwnMessage,
    this.imageUrl,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: context.width * 0.7),
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.04,
        vertical: context.height * 0.01,
      ),
      decoration: BoxDecoration(
        color: isOwnMessage
            ? context.colors.surface
            : context.colors.tertiaryFixedDim,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(context.width * 0.04),
          topRight: Radius.circular(context.width * 0.04),
          bottomLeft: Radius.circular(
            isOwnMessage ? context.width * 0.04 : context.width * 0.01,
          ),
          bottomRight: Radius.circular(
            isOwnMessage ? context.width * 0.01 : context.width * 0.04,
          ),
        ),
        border: !isOwnMessage
            ? Border.all(
                color: context.colors.primary.withOpacity(0.2),
                width: 1,
              )
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null && imageUrl!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(context.width * 0.02),
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: context.width * 0.6,
                fit: BoxFit.cover,
              ),
            ),
            if (content != null && content!.isNotEmpty)
              SizedBox(height: context.height * 0.008),
          ],
          if (content != null && content!.isNotEmpty)
            TextComponent(
              text: content!,
              size: FontSizeConstants.NORMAL,
              color: isOwnMessage
                  ? context.colors.primary
                  : context.colors.primary,
              tr: false,
            ),
        ],
      ),
    );
  }
}
