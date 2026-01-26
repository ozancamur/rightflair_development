import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import '../../../core/components/text/text.dart';
import '../../../../core/extensions/context.dart';

class SettingsSectionHeaderWidget extends StatelessWidget {
  final String title;
  const SettingsSectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.04,
        vertical: context.height * 0.01,
      ),
      child: TextComponent(
        text: title,
        size: FontSizeConstants.SMALL,
        color: context.colors.primaryContainer,
        weight: FontWeight.w600,
      ),
    );
  }
}
