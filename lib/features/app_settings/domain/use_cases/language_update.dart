import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/error/failure.dart';
import 'package:flutter_bloc_template/core/use_case/use_case.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/repositories/app_settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class LanguageUpdateParams {
  final Locale locale;

  LanguageUpdateParams({required this.locale});
}

class LanguageUpdate implements UseCase<Locale, LanguageUpdateParams> {
  LanguageUpdate({
    required AppSettingsRepository appSettingsRepository,
  }) : _appSettingsRepository = appSettingsRepository;

  final AppSettingsRepository _appSettingsRepository;

  @override
  Future<Either<Failure, Locale>> call(LanguageUpdateParams params) async {
    return await _appSettingsRepository.saveLanguage(params.locale);
  }
}
