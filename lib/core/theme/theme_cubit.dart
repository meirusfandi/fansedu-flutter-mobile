import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fansedu_flutter_mobile/core/theme/theme_state.dart';

abstract class ThemeStorage {
  Future<int?> getThemeModeIndex();
  Future<void> setThemeModeIndex(int index);
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ThemeStorage storage})
      : _storage = storage,
        super(const ThemeState(ThemeMode.system)) {
    _load();
  }

  final ThemeStorage _storage;

  Future<void> _load() async {
    final index = await _storage.getThemeModeIndex();
    if (index != null && index >= 0 && index < ThemeMode.values.length) {
      emit(ThemeState(ThemeMode.values[index]));
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    emit(ThemeState(mode));
    await _storage.setThemeModeIndex(mode.index);
  }

  void toggleDark() {
    final next = state.mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setThemeMode(next);
  }
}
