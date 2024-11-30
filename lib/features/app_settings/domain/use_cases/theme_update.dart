import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/error/failure.dart';
import 'package:flutter_bloc_template/core/use_case/use_case.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/repositories/app_settings_repository.dart';
import 'package:fpdart/fpdart.dart';

class ThemeUpdateParams {
  final ThemeMode themeData;

  ThemeUpdateParams({required this.themeData});
}

class ThemeUpdate implements UseCase<ThemeMode, ThemeUpdateParams> {
  ThemeUpdate({
    required AppSettingsRepository appSettingsRepository,
  }) : _appSettingsRepository = appSettingsRepository;

  final AppSettingsRepository _appSettingsRepository;

  @override
  Future<Either<Failure, ThemeMode>> call(ThemeUpdateParams params) async {
    return await _appSettingsRepository.saveTheme(params.themeData);
  }
}
