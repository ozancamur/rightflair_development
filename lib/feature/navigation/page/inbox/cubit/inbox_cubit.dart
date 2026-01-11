import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/feature/navigation/page/inbox/repository/inbox_repository_impl.dart';
import 'package:rightflair/feature/navigation/page/inbox/cubit/inbox_state.dart';

class InboxCubit extends Cubit<InboxState> {
  final InboxRepositoryImpl _repo;

  InboxCubit(this._repo) : super(InboxInitial());

  Future<void> loadMessages() async {
    emit(InboxLoading());
    try {
      final messages = await _repo.getMessages();
      final notifications = await _repo.getNotifications();
      emit(InboxLoaded(messages, notifications));
    } catch (e) {
      emit(InboxError(e.toString()));
    }
  }
}
