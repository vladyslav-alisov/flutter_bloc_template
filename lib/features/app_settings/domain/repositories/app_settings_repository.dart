import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/error/failure.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/entities/app_metadata.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AppSettingsRepository {
  Future<Locale> getLanguage();
  Future<ThemeMode> getTheme();
  Future<Either<Failure, Locale>> saveLanguage(Locale locale);
  Future<Either<Failure, ThemeMode>> saveTheme(ThemeMode theme);
  Future<AppInfo> getAppInfo();
}
