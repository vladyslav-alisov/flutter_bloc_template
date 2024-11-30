part of 'language_cubit.dart';

@immutable
final class LanguageState extends Equatable {
  final Locale locale;
  final bool isLoading;

  const LanguageState({required this.locale, this.isLoading = false});

  LanguageState copyWith({Locale? locale, bool? isLoading}) {
    return LanguageState(
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [locale, isLoading];
}
