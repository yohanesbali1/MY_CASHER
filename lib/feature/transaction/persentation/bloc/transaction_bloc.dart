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
    });
  }
  final TransactionRepository transactionRepository;
  Future<void> _onGetData(GetTransactionEvent event, Emitter emit) async {
    final data = await transactionRepository.getData(page: state.page);
    emit(state.copyWith(data: data));
  }
}
