import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/icons.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../core/components/appbar.dart';
import '../../../core/components/icon_button.dart';
import '../../../core/constants/string.dart';

class CreatePostAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const CreatePostAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBarComponent(
      leading: Padding(
        padding: EdgeInsets.only(left: context.width * .04),
        child: IconButtonComponent(icon: AppIcons.BACK, onTap: () {}),
      ),
      title: AppStrings.CREATE_POST_APPBAR,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
