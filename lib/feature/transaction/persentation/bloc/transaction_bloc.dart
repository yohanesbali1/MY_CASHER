import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_casher/feature/pos/data/repository/transaction_repository.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc(this.transactionRepository) : super(TransactionState()) {
    on<TransactionEvent>((event, emit) async {
      if (event is GetTransactionEvent) {
        await _onGetData(event, emit);
      }
      if (event is GetTransactionListEvent) {
        await _onGetDataTransaction(event, emit);
      }
      if (event is GetSumTransactionEvent) {
        await _onGetSUMTransaction(event, emit);
      }
    });
  }
  final TransactionRepository transactionRepository;

  Future<void> _onGetData(GetTransactionEvent event, Emitter emit) async {
    final now = DateTime.now();
    emit(
      state.copyWith(
        isLoading: true,
        page: 1,
        startDate: DateTime(now.year, now.month, 1),
        endDate: DateTime(
          now.year,
          now.month + 1,
          1,
        ).subtract(const Duration(milliseconds: 1)),
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    await _onGetSUMTransaction(GetSumTransactionEvent(), emit);
    await _onGetDataTransaction(GetTransactionListEvent(), emit);
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onGetDataTransaction(
    GetTransactionListEvent event,
    Emitter emit,
  ) async {
    final data = await transactionRepository.getData(
      page: state.page,
      startDate: state.startDate,
      endDate: state.endDate,
    );
    emit(state.copyWith(data: data));
  }

  Future<void> _onGetSUMTransaction(
    GetSumTransactionEvent event,
    Emitter emit,
  ) async {
    final data = await transactionRepository.getSummary(
      startDate: state.startDate,
      endDate: state.endDate,
    );
    emit(
      state.copyWith(
        totalItem: data?.totalItem,
        totalTransaction: data?.totalTransaction,
        totalRevenue: data?.totalRevenue,
      ),
    );
  }
}
