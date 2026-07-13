part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {
  const TransactionEvent();
}

class GetTransactionEvent extends TransactionEvent {
  const GetTransactionEvent();
}

class GetTransactionListEvent extends TransactionEvent {
  const GetTransactionListEvent();
}

class GetSumTransactionEvent extends TransactionEvent {
  const GetSumTransactionEvent();
}
