part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeInitialized extends ThemeEvent {}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;
  ThemeChanged(this.themeMode);
}
