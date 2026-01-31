import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class MessageIsReadIndicatorWidget extends StatelessWidget {
  final bool isNextMessageSameSender;
  final bool? isRead;
  const MessageIsReadIndicatorWidget({
    super.key,
    required this.isNextMessageSameSender,
    this.isRead,
  });

  @override
  Widget build(BuildContext context) {
    return isNextMessageSameSender
        ? SizedBox(width: context.width * 0.04)
        : Icon(
            isRead == true ? Icons.done_all : Icons.done,
            size: context.width * 0.04,
            color: isRead == true
                ? context.colors.primaryContainer
                : context.colors.tertiary,
          );
  }
}
