part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class AuthenticationLoading extends AuthenticationState {}

final class AuthenticationSetUsername extends AuthenticationState {
  final bool isUnique;
  final bool isCaseInsensitive;
  const AuthenticationSetUsername({
    required this.isUnique,
     this.isCaseInsensitive = true,
  });

  AuthenticationSetUsername copyWith({
    bool? isUnique,
    bool? isCaseInsensitive,
  }) {
    return AuthenticationSetUsername(
      isUnique: isUnique ?? this.isUnique,
      isCaseInsensitive: isCaseInsensitive ?? this.isCaseInsensitive,
    );
  }

  @override
  List<Object> get props => [isUnique, isCaseInsensitive];
}

final class AuthenticationSuccess extends AuthenticationState {}

final class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);

  @override
  List<Object> get props => [message];
}
