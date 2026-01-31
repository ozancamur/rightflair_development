import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/string.dart';

import '../../../core/extensions/context.dart';
import 'choose_username_validation_item.dart';

class ChooseUsernameValidationWidget extends StatelessWidget {
  final bool? isUnique;
  final int textLength;

  const ChooseUsernameValidationWidget({
    super.key,
    required this.isUnique,
    required this.textLength,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMinLengthValid = textLength >= 4;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.width * .03),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: context.height * .015,
        children: [
          ChooseUsernameValidationItem(
            label: AppStrings.CHOOSE_USERNAME_MIN_LENGTH,
            isUnique: isMinLengthValid,
          ),
          ChooseUsernameValidationItem(
            label: AppStrings.CHOOSE_USERNAME_UNIQUE,
            isUnique: isMinLengthValid ? (isUnique ?? false) : false,
          ),
        ],
      ),
    );
  }
}
