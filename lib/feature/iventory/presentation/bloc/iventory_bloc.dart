import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'iventory_event.dart';
part 'iventory_state.dart';

class IventoryBloc extends Bloc<IventoryEvent, IventoryState> {
  IventoryBloc() : super(IventoryState()) {
    on<IventoryEvent>((event, emit) {
      if (event is IventoryTabChanged) {
        _onChanged(event, emit);
      }
    });
  }
  Future<void> _onChanged(
    IventoryTabChanged event,
    Emitter<IventoryState> emit,
  ) async {
    emit(state.copyWith(currentIndex: event.index));
  }
}
