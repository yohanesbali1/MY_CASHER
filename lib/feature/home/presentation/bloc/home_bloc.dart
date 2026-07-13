import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/bloc/transaction_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required this.iventoryBloc, required this.transactionBloc})
    : super(HomeState()) {
    on<HomeEvent>((event, emit) {
      if (event is HomeInitialized) {
        _onInitialized(event, emit);
      }
      if (event is HomeTabChanged) {
        _onChanged(event, emit);
      }
    });
  }
  final IventoryBloc iventoryBloc;
  final TransactionBloc transactionBloc;
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
    switch (event.index) {
      case 0:
        break;
      case 1:
        transactionBloc.add(GetTransactionEvent());
        break;
      case 2:
        iventoryBloc.add(IventoryStarted());
        break;
    }
  }
}
