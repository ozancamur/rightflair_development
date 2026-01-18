import 'package:flutter/material.dart';

import '../../../../core/components/elevated_button.dart';
import '../../../../core/components/text.dart';
import '../../../../core/constants/font/font_size.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';

class LoginButtonWidget extends StatelessWidget {
  const LoginButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonComponent(
      height: context.height * .07,
      radius: 100,
      color: context.colors.outline,
      onPressed: () {},
      child: TextComponent(
        color: context.colors.primaryContainer,
        text: AppStrings.LOGIN,
        size: FontSizeConstants.LARGE,
        weight: FontWeight.w600,
      ),
    );
  }
}
