import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightflair/core/firebase/authentication.dart';

import '../../../core/firebase/firestore/firestore_authentication.dart';

part 'choose_username_event.dart';
part 'choose_username_state.dart';

class ChooseUsernameBloc
    extends Bloc<ChooseUsernameEvent, ChooseUsernameState> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();

  final FirestoreAuthenticationManager _firestoreAuthentication =
      FirestoreAuthenticationManager();
  final FirebaseAuthenticationManager _authentication =
      FirebaseAuthenticationManager();

  ChooseUsernameBloc() : super(ChooseUsernameState()) {
    on<ChooseUsernameSaveEvent>(_onSave);
  }

  Future<void> _onSave(
    ChooseUsernameSaveEvent event,
    Emitter<ChooseUsernameState> emit,
  ) async {
    try {
      if (controller.text.trim().isEmpty) return;
      final isUnique = await _firestoreAuthentication.isUsernameUnique(
        controller.text,
      );
      debugPrint("USERNAME ${controller.text} is UNOQUE :> $isUnique");
      emit(state.copyWith(isUnique: isUnique));
      if (isUnique) {
        try {
          final uid = _authentication.currentUser?.uid;
          if (uid == null) {
            return;
          }
          await _firestoreAuthentication.saveUsername(
            uid: uid,
            username: controller.text,
          );
        } catch (e) {
          debugPrint('Kullanıcı adı kaydedilirken hata oluştu: $e');
        }
      }
    } catch (e) {
      debugPrint('Username kaydedilemedi: $e');
    }
  }
}
