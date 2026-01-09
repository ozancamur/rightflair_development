import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/elevated_button.dart';
import '../../../core/components/text.dart';
import '../../../core/constants/dark_color.dart';
import '../../../core/constants/font_size.dart';
import '../../../core/constants/string.dart';
import '../../../core/extensions/context.dart';
import '../bloc/choose_username_bloc.dart';

class ChooseUsernameButtonWidget extends StatelessWidget {
  final bool isEnabled;
  final String username;

  const ChooseUsernameButtonWidget({
    super.key,
    required this.isEnabled,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButtonComponent(
      height: context.height * .07,
      radius: 100,
      color: isEnabled
          ? AppDarkColors.DARK_BUTTON
          : AppDarkColors.DARK_BUTTON.withOpacity(0.5),
      onPressed: isEnabled
          ? () {
              context.read<ChooseUsernameBloc>().add(
                ChooseUsernameSaveEvent(username: username),
              );
            }
          : null,
      child: TextComponent(
        color: AppDarkColors.WHITE75,
        text: AppStrings.CONTINUE,
        size: FontSizeConstants.LARGE,
        weight: FontWeight.w600,
      ),
    );
  }
}
