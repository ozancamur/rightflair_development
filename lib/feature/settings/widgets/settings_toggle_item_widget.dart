import 'package:flutter/material.dart';
import '../../../core/components/button/settings_toggle_button.dart';
import '../../../core/components/text/text.dart';
import '../../../../core/extensions/context.dart';
import '../../../core/constants/font/font_size.dart';

class SettingsToggleItemWidget extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleItemWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.04,
        vertical: context.height * 0.018,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextComponent(
            text: title,
            size: FontSizeConstants.LARGE,
            color: context.colors.primary,
            weight: FontWeight.w500,
          ),
          SettingsToggleComponent(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
