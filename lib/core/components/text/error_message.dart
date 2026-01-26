import 'package:flutter/material.dart';

import 'text.dart';

class ErrorMessageComponent extends StatelessWidget {
  final String message;
  const ErrorMessageComponent({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: TextComponent(text: message));
  }
}
