import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/use_cases/language_update.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final LanguageUpdate _languageUpdate;

  LanguageCubit({
    required Locale initLocale,
    required LanguageUpdate languageUpdate,
  })  : _languageUpdate = languageUpdate,
        super(LanguageState(locale: initLocale));

  void updateLanguage(Locale locale) async {
    emit(state.copyWith(isLoading: true));
    final result = await _languageUpdate.call(LanguageUpdateParams(locale: locale));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false)),
      (r) => emit(state.copyWith(isLoading: false, locale: r)),
    );
  }
}
