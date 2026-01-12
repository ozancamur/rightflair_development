import 'package:flutter/material.dart';

import '../../../../../../core/extensions/context.dart';

class SuggestedAccountImageWidget extends StatelessWidget {
  final String image;
  const SuggestedAccountImageWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: context.width * 0.06,
      backgroundImage: NetworkImage(image),
    );
  }
}
