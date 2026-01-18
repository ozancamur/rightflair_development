import 'package:flutter/material.dart';

import '../../../core/extensions/context.dart';

class SettingsDividerWidget extends StatelessWidget {
  const SettingsDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(height: .5, color: context.colors.primaryFixed);
  }
}
