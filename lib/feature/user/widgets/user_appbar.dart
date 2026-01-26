import 'package:flutter/material.dart';
import 'package:rightflair/core/components/button/back_button.dart';

import '../../../../../../../core/components/appbar.dart';
import '../../../core/components/button/icon_button.dart';
import '../../../../../../../core/constants/icons.dart';
import '../../../../../../../core/extensions/context.dart';
import '../../../core/components/button/settings_button.dart';

class UserAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const UserAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarComponent(
      leading: BackButtonComponent(),
      actions: [
        IconButtonComponent(onTap: () {}, icon: AppIcons.SHARE),
        SizedBox(width: context.width * 0.03),
        SettingsButtonComponent(),
        SizedBox(width: context.width * .04),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
