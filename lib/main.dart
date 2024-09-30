import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/init_dependencies.dart';
import 'package:flutter_bloc_template/presentation/app_error.dart';

import 'presentation/app.dart';

const String appStoreUrl = "https://apps.apple.com/tr/app/flickermail/id6476929326";
const String playMarketUrl = "https://play.google.com/store/apps/details?id=com.flickermail.app";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    initDependencies();
    runApp(const App());
  } catch (e) {
    runApp(AppError(error: e));
  }
}
