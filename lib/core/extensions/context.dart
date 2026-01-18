import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {

  ThemeData get _theme => Theme.of(this);
  ColorScheme get colors => _theme.colorScheme;

  Size get _size => MediaQuery.of(this).size;
  double get height => _size.height;
  double get width => _size.width;
}
