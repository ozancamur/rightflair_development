part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationRegisterEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationRegisterEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthenticationLoginEvent extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationLoginEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class AuthtenticationAppleEvent extends AuthenticationEvent {}

class AuthtenticationGoogleEvent extends AuthenticationEvent {}

class AuthenticationSetUsernameEvent extends AuthenticationEvent {
  final String username;

  const AuthenticationSetUsernameEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class AuthenticationSaveUsernameEvent extends AuthenticationEvent {
  final String username;

  const AuthenticationSaveUsernameEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class AuthenticationResetPasswordEvent extends AuthenticationEvent {
  final String email;
  const AuthenticationResetPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}
