part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialized extends HomeEvent {}

class HomeRefreshRequested extends HomeEvent {}

class HomeTabChanged extends HomeEvent {
  final int index;

  HomeTabChanged(this.index);
}
