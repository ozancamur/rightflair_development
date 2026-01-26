import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/core/constants/route.dart';

import '../../constants/icons.dart';
import 'icon_button.dart';

class SettingsButtonComponent extends StatelessWidget {
  final VoidCallback? onSettings;
  const SettingsButtonComponent({super.key, this.onSettings});

  @override
  Widget build(BuildContext context) {
    return IconButtonComponent(
      icon: AppIcons.SETTINGS,
      onTap: onSettings ?? () => context.push(RouteConstants.SETTINGS),
    );
  }
}
