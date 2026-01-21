class SupabaseAuthException implements Exception {
  final String message;

  SupabaseAuthException(this.message);

  @override
  String toString() => 'SupabaseAuthException: $message';
}
