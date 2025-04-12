import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/router/app_routes.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/settings_screen.dart';
import 'package:flutter_bloc_template/init/init_error_screen.dart';
import 'package:flutter_bloc_template/init/init_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static GoRouter? _goRouter;

  static GoRouter get router => _goRouter == null ? throw Exception("Init router first") : _goRouter!;

  static GlobalKey get navigatorKey => _rootNavigatorKey;

  static GoRouter initRouter() {
    _goRouter ??= GoRouter(
      initialLocation: AppRoutes.init.path,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoutes.init.path,
          builder: (context, state) => const InitScreen(),
        ),
        GoRoute(
          path: AppRoutes.initError.path,
          builder: (context, state) => InitErrorScreen(error: state.extra as dynamic),
        ),
        GoRoute(
          path: AppRoutes.settings.path,
          builder: (context, state) => SettingsScreen(),
        ),
      ],
    );
    return _goRouter!;
  }
}
