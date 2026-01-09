import 'package:flutter/material.dart';

import '../../../../core/components/elevated_button.dart';
import '../../../../core/components/text.dart';
import '../../../../core/constants/dark_color.dart';
import '../../../../core/constants/font_size.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';

class RegisterButtonWidget extends StatelessWidget {
  final Function() onRegister;
  const RegisterButtonWidget({super.key, required this.onRegister});

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonComponent(
      height: context.height * .07,
      radius: 100,
      color: AppDarkColors.DARK_BUTTON,
      onPressed: onRegister,
      child: TextComponent(
        color: AppDarkColors.WHITE75,
        text: AppStrings.REGISTER_CREATE_ACCOUNT,
        size: FontSizeConstants.LARGE,
        weight: FontWeight.w600,
      ),
    );
  }
}
