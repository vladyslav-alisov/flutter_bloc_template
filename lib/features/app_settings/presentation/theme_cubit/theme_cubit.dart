import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/use_cases/theme_update.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeUpdate _themeUpdate;

  ThemeCubit({required ThemeMode initThemeMode, required ThemeUpdate themeUpdate})
      : _themeUpdate = themeUpdate,
        super(ThemeState(theme: initThemeMode));

  void updateTheme(ThemeMode theme) async {
    emit(state.copyWith(isLoading: true));
    final result = await _themeUpdate.call(ThemeUpdateParams(themeData: theme));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false)),
      (r) => emit(state.copyWith(isLoading: false, theme: r)),
    );
  }
}
