import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/core/app_info/app_info_provider.dart';
import 'package:flutter_bloc_template/core/config_loader/config_loader.dart';
import 'package:flutter_bloc_template/core/config_loader/config_loader_impl.dart';
import 'package:flutter_bloc_template/core/const/assets.gen.dart';
import 'package:flutter_bloc_template/core/l10n/translate_extension.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/language_widget.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/report_feedback_widget.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/settings_list_tile.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/share_app_widget.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/widgets/theme_mode_widget.dart';
import 'package:flutter_bloc_template/init_dependencies.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key}) {
    _appInfoProvider = serviceLocator<AppInfoProvider>();
    _configLoader = serviceLocator<ConfigLoader>();
  }

  late final AppInfoProvider _appInfoProvider;
  late final ConfigLoader _configLoader;

  void _onAboutPress(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: _appInfoProvider.appName,
      children: [
        const Text("Information about the app"),
      ],
      applicationIcon: Image.asset(
        Assets.images.logo.path,
        height: 55,
        width: 55,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LanguageWidget(),
            const ThemeModeWidget(),
            ShareAppWidget(
              appStoreUrl: _configLoader.get(EnvVariable.appStoreUrl.key) ?? "",
              playMarketUrl: _configLoader.get(EnvVariable.playStoreUrl.key) ?? "",
            ),
            ReportFeedbackWidget(
              appName: _appInfoProvider.appName,
              appVersion: _appInfoProvider.version,
              feedbackEmail: _configLoader.get(EnvVariable.supportEmail.key) ?? "",
            ),
            SettingsListTile(
              leadingIcon: Icons.info_outline,
              title: "About",
              onTap: () => _onAboutPress(context),
            ),
          ],
        ),
      ),
    );
  }
}
