part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {
  const TransactionEvent();
}

class GetTransactionEvent extends TransactionEvent {
  const GetTransactionEvent();
}
