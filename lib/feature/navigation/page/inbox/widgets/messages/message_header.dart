import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/font/font_size.dart';

import '../../../../../../core/components/text/text.dart';
import '../../../../../../core/extensions/context.dart';

class MessageHeaderWidget extends StatelessWidget {
  final String senderName;
  final DateTime timestamp;
  const MessageHeaderWidget({
    super.key,
    required this.senderName,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextComponent(
          text: senderName,
          size: FontSizeConstants.LARGE,
          weight: FontWeight.w600,
          color: context.colors.primary,
          tr: false,
        ),
        TextComponent(
          text: _formatTime(timestamp),
          size: const [12],
          color: context.colors.scrim,
          tr: false,
        ),
      ],
    );
  }

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }
}
