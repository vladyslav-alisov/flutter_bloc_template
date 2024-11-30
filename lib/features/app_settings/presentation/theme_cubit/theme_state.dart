part of 'theme_cubit.dart';

@immutable
final class ThemeState extends Equatable {
  final ThemeMode theme;
  final bool isLoading;

  const ThemeState({
    required this.theme,
    this.isLoading = false,
  });

  ThemeState copyWith({
    ThemeMode? theme,
    bool? isLoading,
  }) {
    return ThemeState(
      theme: theme ?? this.theme,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [theme, isLoading];
}
