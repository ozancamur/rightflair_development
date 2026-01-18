import 'package:flutter/material.dart';

import '../extensions/context.dart';

class LoadingComponent extends StatelessWidget {
  const LoadingComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color: context.colors.scrim),
    );
  }
}
