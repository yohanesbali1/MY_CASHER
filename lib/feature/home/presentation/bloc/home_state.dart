part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

@immutable
class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.message = '',
    this.error,
    this.currentIndex = 0,
  });

  final HomeStatus status;
  final String message;
  final Object? error;
  final int currentIndex;

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    Object? error,
    int? currentIndex,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      error: error ?? this.error,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
