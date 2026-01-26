import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../../../../core/components/text/text.dart';

class MessageContentWidget extends StatelessWidget {
  final String lastMessage;
  const MessageContentWidget({
    super.key,
    required this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextComponent(
            text: lastMessage,
            size: FontSizeConstants.SMALL,
            color: context.colors.tertiary,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
          Container(
            width: context.width * .02,
            height: context.width * .02,
            decoration: BoxDecoration(
              color: context.colors.scrim,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }
}
