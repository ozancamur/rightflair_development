part of 'choose_username_bloc.dart';

sealed class ChooseUsernameEvent extends Equatable {
  const ChooseUsernameEvent();

  @override
  List<Object> get props => [];
}

class ChooseUsernameSaveEvent extends ChooseUsernameEvent {}
