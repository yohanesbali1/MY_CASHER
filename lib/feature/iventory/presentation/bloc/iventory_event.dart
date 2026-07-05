part of 'iventory_bloc.dart';

@immutable
sealed class IventoryEvent {}

class IventoryStarted extends IventoryEvent {
  IventoryStarted();
}

class IventoryTabChanged extends IventoryEvent {
  final int index;

  IventoryTabChanged(this.index);
}
