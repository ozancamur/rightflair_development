import 'package:flutter/material.dart';
import 'package:rightflair/core/extensions/context.dart';

import '../../../core/components/text.dart';

class LocationEmptyWidget extends StatelessWidget {
  const LocationEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextComponent(
        text: "No results found", // Should be in String constants ideally
        color: context.colors.onPrimary,
      ),
    );
  }
}