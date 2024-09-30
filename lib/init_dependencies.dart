import 'package:dio/dio.dart';
import 'package:flutter_bloc_template/core/config_loader/config_loader.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final serviceLocator = GetIt.instance;

const Duration _connectTimeout = Duration(seconds: 25);

Future<void> initDependencies() async {
  /// APP ENV VARIABLES
  final ConfigLoader configLoader = DotenvConfigLoaderImpl(".env");
  await configLoader.load();

  SharedPreferences preferences = await SharedPreferences.getInstance();

  /// NETWORK
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: _connectTimeout,
      receiveTimeout: _connectTimeout,
      headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      },
      baseUrl: configLoader.get(EnvVariable.baseUrl.key) ?? "",
    ),
  );

  serviceLocator.registerSingleton<Dio>(dio);
  serviceLocator.registerSingleton<ConfigLoader>(configLoader);
  serviceLocator.registerSingleton<SharedPreferences>(preferences);
}
