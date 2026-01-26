import 'package:flutter/material.dart';

import '../../../../core/components/text/text_field.dart';
import '../../../../core/constants/regexp.dart';
import '../../../../core/constants/string.dart';

class ForgotPasswordTextField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  const ForgotPasswordTextField({
    super.key,
    required this.formKey,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFieldComponent(
        controller: controller,
        hintText: AppStrings.EMAIL,
        regExp: RegExpConstants.EMAIL,
        errorText: AppStrings.VALIDATION_EMAIL_INVALID,
      ),
    );
  }
}
