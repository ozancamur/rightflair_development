import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/core/constants/route.dart';

import '../../../../core/components/text.dart';
import '../../../../core/constants/font/font_size.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';

class LoginForgotPasswordWidget extends StatelessWidget {
  const LoginForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.push(RouteConstants.FORGOT_PASSWORD),
      child: TextComponent(
        text: AppStrings.FORGOT_PASSWORD,
        size: FontSizeConstants.SMALL,
        weight: FontWeight.w500,
        color: context.colors.primaryContainer,
      ),
    );
  }
}
