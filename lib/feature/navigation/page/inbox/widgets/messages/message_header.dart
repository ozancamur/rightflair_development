import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/font_size.dart';

import '../../../../../../core/components/text.dart';
import '../../../../../../core/constants/dark_color.dart';

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
          color: AppDarkColors.PRIMARY,
          tr: false,
        ),
        TextComponent(
          text: _formatTime(timestamp),
          size: const [12],
          color: AppDarkColors.ORANGE,
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
