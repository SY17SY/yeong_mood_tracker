import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yeong_mood_tracker/models/settings_model.dart';
import 'package:yeong_mood_tracker/repos/settings_repo.dart';

class SettingsViewModel extends Notifier<SettingsModel> {
  final SettingsRepository _repository;

  SettingsViewModel(this._repository);

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = SettingsModel(
      darkMode: value,
      followSystem: state.followSystem,
    );
  }

  void setFollowSystem(bool value) {
    _repository.setFollowSystem(value);
    state = SettingsModel(
      darkMode: state.darkMode,
      followSystem: value,
    );
  }

  ThemeMode get themeMode {
    if (state.followSystem) {
      return ThemeMode.system;
    }
    return state.darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  SettingsModel build() {
    return SettingsModel(
      darkMode: _repository.isDarkMode(),
      followSystem: _repository.isFollowSystem(),
    );
  }
}

final settingsProvider = NotifierProvider<SettingsViewModel, SettingsModel>(
  () => throw UnimplementedError(),
);
