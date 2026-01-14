import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extensions/context.dart';

class SettingsToggleComponent extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const SettingsToggleComponent({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: context.width * 0.0022,
      child: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFF4CAF50),
        trackColor: const Color(0xFF2A2A2A),
      ),
    );
  }
}
