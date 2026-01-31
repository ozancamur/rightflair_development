import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart' as intl;
import 'package:flutter/material.dart';

import '../../../../core/components/text/text.dart';
import '../../../../core/constants/font/font_size.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';

class MessageTimeWidget extends StatelessWidget {
  final DateTime? createdAt;
  const MessageTimeWidget({super.key, this.createdAt});

  @override
  Widget build(BuildContext context) {
    return (createdAt == null)
        ? const SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.02),
            child: TextComponent(
              text: _formatTime(createdAt!),
              size: FontSizeConstants.XXX_SMALL,
              color: context.colors.tertiary,
              tr: false,
            ),
          );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return intl.DateFormat('HH:mm').format(dateTime);
    } else if (difference.inDays == 1) {
      return '${AppStrings.CHAT_YESTERDAY.tr()} ${intl.DateFormat('HH:mm').format(dateTime)}';
    } else if (difference.inDays < 7) {
      return intl.DateFormat('EEEE HH:mm').format(dateTime);
    } else {
      return intl.DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    }
  }
}
