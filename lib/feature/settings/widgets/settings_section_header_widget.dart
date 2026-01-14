import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/dark_color.dart';
import 'package:rightflair/core/constants/font_size.dart';
import '../../../../core/components/text.dart';
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
        color: AppDarkColors.WHITE75,
        weight: FontWeight.w600,
      ),
    );
  }
}
