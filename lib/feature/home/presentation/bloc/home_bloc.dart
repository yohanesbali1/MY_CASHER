import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      if (event is HomeInitialized) {
        _onInitialized(event, emit);
      }
      if (event is HomeTabChanged) {
        _onChanged(event, emit);
      }
    });
  }
  Future<void> _onInitialized(
    HomeInitialized event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      emit(state.copyWith(status: HomeStatus.success, message: ''));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, message: e.toString()));
    }
  }

  Future<void> _onChanged(HomeTabChanged event, Emitter<HomeState> emit) async {
    emit(state.copyWith(currentIndex: event.index));
  }
}
