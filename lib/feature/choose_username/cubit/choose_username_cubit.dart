import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rightflair/feature/choose_username/repository/choose_username_repository_impl.dart';

import '../../../core/constants/route.dart';

part 'choose_username_state.dart';

class ChooseUsernameCubit extends Cubit<ChooseUsernameState> {
  final FocusNode focusNode = FocusNode();
  final TextEditingController controller = TextEditingController();
  Timer? _debounceTimer;

  static const int minUsernameLength = 4;

  final ChooseUsernameRepositoryImpl _repo;
  ChooseUsernameCubit(this._repo) : super(ChooseUsernameState());

  void onTextChanged() {
    final currentText = controller.text.toLowerCase().trim();

    _debounceTimer?.cancel();

    if (state.checkedUsername != null && state.checkedUsername != currentText) {
      emit(
        state.copyWith(
          isUnique: null,
          checkedUsername: null,
          suggestions: null,
        ),
      );
    }

    if (currentText.length >= minUsernameLength) {
      _debounceTimer = Timer(const Duration(seconds: 1), () {
        _checkUsername(currentText);
      });
    }
  }

  Future<void> _checkUsername(String username) async {
    try {
      emit(state.copyWith(isLoading: true));

      final result = await _repo.checkUsername(username: username);
      final bool isUnique = result['isUnique'] as bool;
      final List<String> suggestions =
          result['suggestions'] as List<String>? ?? [];

      emit(
        state.copyWith(
          isLoading: false,
          isUnique: isUnique,
          checkedUsername: username,
          suggestions: suggestions.isNotEmpty ? suggestions : null,
        ),
      );
    } catch (e) {
      debugPrint('Username kontrol edilemedi: $e');
      emit(state.copyWith(isLoading: false));
    }
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    controller.dispose();
    focusNode.dispose();
    return super.close();
  }

  Future<void> onCheck(BuildContext context) async {
    final username = controller.text.toLowerCase().trim();
    if (username.length < minUsernameLength) return;
    _debounceTimer?.cancel();
    await _checkUsername(username);
  }

  Future<void> onSave(BuildContext context, bool canPop) async {
    try {
      final username = controller.text.toLowerCase().trim();
      if (username.length < minUsernameLength) return;
      emit(state.copyWith(isLoading: true));
      final response = await _repo.updatedUser(
        username: username,
      );
      if (response == null || response.success != true) {
        emit(state.copyWith(isLoading: false));
        return;
      } else {
        if (response.success == true && context.mounted) {
          if (canPop) {
            context.pop(controller.text);
          } else {
            context.go(RouteConstants.NAVIGATION);
          }
          emit(state.copyWith(isLoading: false, isUnique: null));
          controller.clear();
        }
      }
    } catch (e) {
      debugPrint('Username kaydedilemedi: $e');
      emit(state.copyWith(isLoading: false));
    }
  }
}
