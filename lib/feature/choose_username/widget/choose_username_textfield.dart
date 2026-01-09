import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightflair/core/components/text.dart';
import 'package:rightflair/core/constants/dark_color.dart';
import 'package:rightflair/core/constants/font_size.dart';

import '../../../core/components/text_field.dart';
import '../../../core/constants/string.dart';
import '../../../core/extensions/context.dart';

class ChooseUsernameTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool? isValid;
  const ChooseUsernameTextField({
    super.key,
    required this.controller,
    this.isValid,
  });

  @override
  Widget build(BuildContext context) {
    return controller.text == ""
        ? _field()
        : _valid(context, controller.text, isValid ?? false);
  }

  TextFieldComponent _field() {
    return TextFieldComponent(
      key: const ValueKey('username_textfield'),
      controller: controller,
      hintText: AppStrings.CHOOSE_USERNAME_USERNAME,
      regExp: RegExp(''),
      errorText: "",
    );
  }

  Column _valid(BuildContext context, String username, bool isValid) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_field(), _text(context, username, isValid)],
    );
  }

  Padding _text(BuildContext context, String username, bool isValid) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .05),
      child: TextComponent(
        text:
            (isValid
                    ? AppStrings.CHOOSE_USERNAME_IS_AVAILABLE
                    : AppStrings.CHOOSE_USERNAME_IS_NOT_AVAILABLE)
                .tr(args: [username]),
        color: isValid ? AppDarkColors.GREEN : AppDarkColors.RED,
        size: FontSizeConstants.XX_SMALL,
        weight: FontWeight.w400,
      ),
    );
  }
}
