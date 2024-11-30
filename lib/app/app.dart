import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/locales.dart';
import 'package:flutter_bloc_template/core/router/app_router.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/language_cubit/language_cubit.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/theme_cubit/theme_cubit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.initRouter(),
      locale: context.watch<LanguageCubit>().state.locale,
      themeMode: context.watch<ThemeCubit>().state.theme,
      theme: FlexThemeData.light(scheme: FlexScheme.bahamaBlue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.bigStone),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
    );
  }
}
