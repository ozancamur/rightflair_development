import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:rightflair/core/constants/regexp.dart';

import '../../../../core/components/text/password_text_field.dart';
import '../../../../core/components/text/text_field.dart';
import '../../../../core/constants/string.dart';
import '../../../../core/extensions/context.dart';

class RegisterInputsWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final TextEditingController ctrlConfirmPassword;
  const RegisterInputsWidget({
    super.key,
    required this.formKey,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.ctrlConfirmPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.height * .01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: context.height * .015,
          children: [
            TextFieldComponent(
              controller: ctrlEmail,
              hintText: AppStrings.EMAIL,
              regExp: RegExpConstants.EMAIL,
              errorText: AppStrings.VALIDATION_EMAIL_INVALID,
            ),
            PasswordTextFieldComponent(
              controller: ctrlPassword,
              hintText: AppStrings.PASSWORD,
              regExp: RegExpConstants.PASSWORD,
              errorText: AppStrings.VALIDATION_PASSWORD_INVALID,
            ),
            PasswordTextFieldComponent(
              controller: ctrlConfirmPassword,
              hintText: AppStrings.CONFIRM_PASSWORD,
              regExp: RegExpConstants.PASSWORD,
              errorText: AppStrings.VALIDATION_CONFIRM_PASSWORD_MISMATCH,
              customValidator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppStrings.VALIDATION_CONFIRM_PASSWORD_REQUIRED.tr();
                } else if (value != ctrlPassword.text) {
                  return AppStrings.VALIDATION_CONFIRM_PASSWORD_MISMATCH.tr();
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}
