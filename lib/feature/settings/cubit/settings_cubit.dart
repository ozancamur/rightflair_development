import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/settings_model.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  void loadSettings() {
    emit(SettingsLoading());

    // Mock data - replace with actual data source
    final settings = SettingsModel(
      username: '@loremipsum',
      email: 'loremipsum@mail.com',
      likesEnabled: true,
      savesEnabled: true,
      milestonesEnabled: true,
      trendingEnabled: true,
      followEnabled: true,
      darkModeEnabled: true,
      language: 'english',
    );

    emit(SettingsLoaded(settings));
  }

  void toggleLikes(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(SettingsLoaded(currentState.settings.copyWith(likesEnabled: value)));
    }
  }

  void toggleSaves(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(SettingsLoaded(currentState.settings.copyWith(savesEnabled: value)));
    }
  }

  void toggleMilestones(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(
        SettingsLoaded(
          currentState.settings.copyWith(milestonesEnabled: value),
        ),
      );
    }
  }

  void toggleTrending(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(
        SettingsLoaded(currentState.settings.copyWith(trendingEnabled: value)),
      );
    }
  }

  void toggleFollow(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(
        SettingsLoaded(currentState.settings.copyWith(followEnabled: value)),
      );
    }
  }

  void toggleDarkMode(bool value) {
    final currentState = state;
    if (currentState is SettingsLoaded) {
      emit(
        SettingsLoaded(currentState.settings.copyWith(darkModeEnabled: value)),
      );
    }
  }

  void logOut() {
    // Implement logout logic
  }

  void deactivateAccount() {
    // Implement account deactivation logic
  }
}
