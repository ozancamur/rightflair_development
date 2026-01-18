import 'package:flutter/material.dart';

import '../../../../core/extensions/context.dart';

class CommentUsernameWidget extends StatelessWidget {
  final String username;
  const CommentUsernameWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Text(
      username,
      style: TextStyle(
        color: context.colors.primary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
