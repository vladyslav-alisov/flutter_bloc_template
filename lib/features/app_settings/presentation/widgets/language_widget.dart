import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/core/l10n/translate_extension.dart';
import 'package:flutter_bloc_template/features/app_settings/presentation/language_cubit/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageWidget extends StatelessWidget {
  LanguageWidget({super.key}) {
    _supportedLocales.addAll(AppLocalizations.supportedLocales);
  }

  final List<Locale> _supportedLocales = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return ExpansionTile(
          leading: const Icon(Icons.language_outlined),
          title: Text(context.l10n.language),
          subtitle: Text(state.locale.fullName),
          children: List.generate(
            _supportedLocales.length,
            (index) => CheckboxListTile(
              title: Text(_supportedLocales[index].fullName),
              value: _supportedLocales[index].languageCode == state.locale.languageCode,
              onChanged: (val) {
                if (state.isLoading) return;
                context.read<LanguageCubit>().updateLanguage(_supportedLocales[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
