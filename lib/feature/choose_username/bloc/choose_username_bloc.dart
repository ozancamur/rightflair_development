import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/firebase/authentication.dart';
import 'package:rightflair/core/firebase/firestore.dart';

part 'choose_username_event.dart';
part 'choose_username_state.dart';

class ChooseUsernameBloc
    extends Bloc<ChooseUsernameEvent, ChooseUsernameState> {
  final FirebaseFirestoreManager _firestore = FirebaseFirestoreManager();
  final FirebaseAuthenticationManager _authentication =
      FirebaseAuthenticationManager();

  ChooseUsernameBloc() : super(ChooseUsernameState()) {
    on<ChooseUsernameCheckEvent>(_onCheck);
    on<ChooseUsernameSaveEvent>(_onSave);
  }

  Future<void> _onCheck(
    ChooseUsernameCheckEvent event,
    Emitter<ChooseUsernameState> emit,
  ) async {
    if (event.username.trim().isEmpty) return;
    final isUnique = await _firestore.isUsernameUnique(event.username);
    emit(state.copyWith(isUnique: isUnique));
  }

  Future<void> _onSave(
    ChooseUsernameSaveEvent event,
    Emitter<ChooseUsernameState> emit,
  ) async {
    try {
      final uid = _authentication.currentUser?.uid;
      if (uid == null) {
        return;
      }
      await _firestore.saveUsername(uid: uid, username: event.username);
    } catch (e) {
      debugPrint('Username kaydedilemedi: $e');
    }
  }
}
