import 'package:flutter/material.dart';

import '../../../../../../core/extensions/context.dart';

class FollowerImageWidget extends StatelessWidget {
  final String url;
  const FollowerImageWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: context.width * 0.055,
      backgroundImage: NetworkImage(url),
    );
  }
}
