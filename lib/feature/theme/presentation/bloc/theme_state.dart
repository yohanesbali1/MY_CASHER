part of 'theme_bloc.dart';

@immutable
class ThemeState {
  final ThemeMode themeMode;
  const ThemeState({required this.themeMode});
  ThemeState copyWith({ThemeMode? themeMode}) =>
      ThemeState(themeMode: themeMode ?? this.themeMode);
}
