import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/app_info/app_info_provider.dart';
import 'package:flutter_bloc_template/core/app_info/app_info_provider_impl.dart';
import 'package:flutter_bloc_template/core/config_loader/config_loader.dart';
import 'package:flutter_bloc_template/core/config_loader/config_loader_impl.dart';
import 'package:flutter_bloc_template/features/app_settings/data/data_sources/app_settings_local_data_source/app_settings_local_data_source.dart';
import 'package:flutter_bloc_template/features/app_settings/data/repositories/app_settings_repository_impl.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/repositories/app_settings_repository.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/use_cases/language_update.dart';
import 'package:flutter_bloc_template/features/app_settings/domain/use_cases/theme_update.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/language_cubit/language_cubit.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/theme_cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

const Duration _connectTimeout = Duration(seconds: 25);

BaseOptions getBaseOptions(String baseUrl) {
  return BaseOptions(
    connectTimeout: _connectTimeout,
    receiveTimeout: _connectTimeout,
    headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
    },
    baseUrl: baseUrl,
  );
}

Future<void> initDependencies() async {
  /// APP ENV VARIABLES
  final ConfigLoader configLoader = DotenvConfigLoaderImpl(".env");
  await configLoader.load();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  AppInfoProvider appInfoProvider = AppInfoProviderImpl(prefs: preferences);
  await appInfoProvider.init();

  /// NETWORK
  String baseUrl = configLoader.get(EnvVariable.baseUrl.key) ?? "";
  final Dio dio = Dio(getBaseOptions(baseUrl));

  _registerSingletonServices(configLoader, preferences, dio, appInfoProvider);

  // Register data sources
  _registerDataSources(dio);

  // Register repositories
  _registerRepositories();

  // Register use-cases
  _registerUseCases();

  Locale locale = await serviceLocator<AppSettingsRepository>().getLanguage();
  ThemeMode themeMode = await serviceLocator<AppSettingsRepository>().getTheme();
  // Register blocs
  _registerBlocs(locale, themeMode);
}

void _registerSingletonServices(
  ConfigLoader configLoader,
  SharedPreferences preferences,
  Dio dio,
  AppInfoProvider appInfoProvider,
) {
  serviceLocator.registerSingleton<Dio>(dio);
  serviceLocator.registerSingleton<ConfigLoader>(configLoader);
  serviceLocator.registerSingleton<SharedPreferences>(preferences);
  serviceLocator.registerSingleton<AppInfoProvider>(appInfoProvider);
}

void _registerDataSources(Dio networkClient) {
  serviceLocator.registerFactory<AppSettingsLocalDataSource>(
    () => SharedPreferencesAppSettingsLocalDataSourceImpl(sharedPreferences: serviceLocator()),
  );
}

void _registerRepositories() {
  serviceLocator.registerFactory<AppSettingsRepository>(
    () => AppSettingsRepositoryImpl(appSettingsLocalDataSource: serviceLocator()),
  );
}

void _registerUseCases() {
  serviceLocator.registerFactory(() => LanguageUpdate(appSettingsRepository: serviceLocator()));
  serviceLocator.registerFactory(() => ThemeUpdate(appSettingsRepository: serviceLocator()));
}

void _registerBlocs(Locale initLocale, ThemeMode initThemeMode) {
  serviceLocator.registerLazySingleton(() => LanguageCubit(
        initLocale: initLocale,
        languageUpdate: serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => ThemeCubit(
        initThemeMode: initThemeMode,
        themeUpdate: serviceLocator(),
      ));
}
