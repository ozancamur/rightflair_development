import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/core/components/text.dart';
import 'package:rightflair/core/constants/font/font_size.dart';
import 'package:rightflair/core/constants/route.dart';
import 'package:rightflair/core/constants/string.dart';

import '../../../core/extensions/context.dart';

class AuthenticationHaveAccountWidget extends StatelessWidget {
  const AuthenticationHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextComponent(
          text: AppStrings.HAVE_ACCOUNT,
          color: context.colors.primaryContainer,
          size: FontSizeConstants.SMALL,
          weight: FontWeight.w500,
        ),
        TextButton(
          onPressed: () => context.push(RouteConstants.LOGIN),
          child: TextComponent(
            text: AppStrings.LOGIN,
            color: context.colors.primary,
            size: FontSizeConstants.SMALL,
            weight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
