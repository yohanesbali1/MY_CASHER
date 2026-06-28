part of 'iventory_bloc.dart';

@immutable
class IventoryState {
  final int currentIndex;
  const IventoryState({this.currentIndex = 0});

  IventoryState copyWith({int? currentIndex}) {
    return IventoryState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
