part of 'choose_username_bloc.dart';

sealed class ChooseUsernameEvent extends Equatable {
  const ChooseUsernameEvent();

  @override
  List<Object> get props => [];
}

class ChooseUsernameCheckEvent extends ChooseUsernameEvent {
  final String username;

  const ChooseUsernameCheckEvent({required this.username});

  @override
  List<Object> get props => [username];
}

class ChooseUsernameSaveEvent extends ChooseUsernameEvent {
  final String username;

  const ChooseUsernameSaveEvent({required this.username});

  @override
  List<Object> get props => [username];
}
