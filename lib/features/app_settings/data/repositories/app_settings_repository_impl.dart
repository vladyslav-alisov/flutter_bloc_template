import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/error/failure.dart';
import 'package:flutter_bloc_template/features/app_settings/data/data_sources/app_settings_local_data_source/app_settings_local_data_source.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/entities/app_metadata.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/repositories/app_settings_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:package_info_plus/package_info_plus.dart';

const String _langCodeKey = "langCode";
const String _themeKey = "theme";
const String _appVersion = "appVersion";
const String _lastVersionUpdate = "lastVersionUpdate";

class AppSettingsRepositoryImpl implements AppSettingsRepository {
  AppSettingsRepositoryImpl({
    required AppSettingsLocalDataSource appSettingsLocalDataSource,
  }) : _appSettingsLocalDataSource = appSettingsLocalDataSource;

  final AppSettingsLocalDataSource _appSettingsLocalDataSource;

  @override
  Future<Locale> getLanguage() async {
    try {
      String? langCode = await _appSettingsLocalDataSource.getSetting(_langCodeKey);
      return Locale(langCode ?? "en");
    } catch (e) {
      /// TODO: send error with analytics
      return const Locale("en");
    }
  }

  @override
  Future<ThemeMode> getTheme() async {
    try {
      String? theme = await _appSettingsLocalDataSource.getSetting(_themeKey);
      ThemeMode themeMode = switch (theme) {
        "system" => ThemeMode.system,
        "dark" => ThemeMode.dark,
        "light" => ThemeMode.light,
        _ => ThemeMode.system,
      };
      return themeMode;
    } catch (e) {
      /// TODO: send error with analytics
      return ThemeMode.system;
    }
  }

  @override
  Future<Either<Failure, Locale>> saveLanguage(Locale locale) async {
    try {
      await _appSettingsLocalDataSource.saveSetting(_langCodeKey, locale.languageCode);
      return right(locale);
    } catch (e) {
      return left(Failure("Persistence error"));
    }
  }

  @override
  Future<Either<Failure, ThemeMode>> saveTheme(ThemeMode theme) async {
    try {
      await _appSettingsLocalDataSource.saveSetting(_langCodeKey, theme.name);
      return right(theme);
    } catch (e) {
      return left(Failure("Persistence error"));
    }
  }


  ///todo: init it somewhere
  @override
  Future<AppInfo> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? lastRecordedVersion = await _appSettingsLocalDataSource.getSetting(_appVersion);

    if (lastRecordedVersion != null && lastRecordedVersion == packageInfo.version) {
      String? lastVersionUpdateStr = await _appSettingsLocalDataSource.getSetting(_lastVersionUpdate);

      late DateTime lastVersionUpdate;
      if (lastVersionUpdateStr == null || DateTime.tryParse(lastVersionUpdateStr) == null) {
        lastVersionUpdate = DateTime.now();
        await _appSettingsLocalDataSource.saveSetting(_lastVersionUpdate, lastVersionUpdate);
      } else {
        lastVersionUpdate = DateTime.parse(lastVersionUpdateStr);
      }
      return AppInfo(
        packageInfo.appName,
        packageInfo.packageName,
        lastRecordedVersion,
        packageInfo.buildNumber,
        packageInfo.buildSignature,
        lastVersionUpdate,
      );
    } else {
      DateTime now = DateTime.now();
      String currentVersion = packageInfo.version;
      await _appSettingsLocalDataSource.saveSetting(_appVersion, currentVersion);
      await _appSettingsLocalDataSource.saveSetting(_lastVersionUpdate, now.toString());
      return AppInfo(
        packageInfo.appName,
        packageInfo.packageName,
        currentVersion,
        packageInfo.buildNumber,
        packageInfo.buildSignature,
        now,
      );
    }

    throw UnimplementedError();
  }
}
