class RegExpConstants {
  static final RegExp EMAIL = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp PASSWORD = RegExp(r'^.{6,}$');
}
