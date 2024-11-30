import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/l10n/translate_extension.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/theme_cubit/theme_cubit.dart';

class ThemeModeWidget extends StatelessWidget {
  const ThemeModeWidget({super.key});

  Map<ThemeMode, String> get _themeModeListToTitle => {
        ThemeMode.system: "System",
        ThemeMode.dark: "Dark",
        ThemeMode.light: "Light",
      };

  List<ThemeMode> get _themeModeList => _themeModeListToTitle.keys.toList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ExpansionTile(
          leading: const Icon(Icons.color_lens_outlined),
          title: Text(context.l10n.theme),
          subtitle: Text(_themeModeListToTitle[state.theme] ?? ""),
          children: List.generate(
            _themeModeListToTitle.length,
            (index) => CheckboxListTile(
              title: Text(_themeModeListToTitle.values.toList()[index]),
              value: _themeModeList[index] == state.theme,
              onChanged: (val) {
                if (state.isLoading) return;
                context.read<ThemeCubit>().updateTheme(_themeModeList[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
