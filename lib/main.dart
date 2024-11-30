import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/app.dart';
import 'package:flutter_bloc_template/app/app_error.dart';
import 'package:flutter_bloc_template/core/bloc_observer/bloc_observer.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/language_cubit/language_cubit.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc_template/init_dependencies.dart';

const String appStoreUrl = "https://apps.apple.com/tr/app/flickermail/id6476929326";
const String playMarketUrl = "https://play.google.com/store/apps/details?id=com.flickermail.app";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Bloc.observer = AppObserver();
    await initDependencies();
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<LanguageCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<ThemeCubit>(),
          ),
        ],
        child: const App(),
      ),
    );
  } catch (e) {
    /// TODO: send analytics
    runApp(AppError(error: e));
  }
}
