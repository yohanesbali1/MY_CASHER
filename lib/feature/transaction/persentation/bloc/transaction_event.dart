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

class ShowTransactionEvent extends TransactionEvent {
  final int id;
  const ShowTransactionEvent(this.id);
}

class FilterTransactionEvent extends TransactionEvent {
  final DateTime? startDate;
  final DateTime? endDate;
  final int? page;
  const FilterTransactionEvent(this.startDate, this.endDate, this.page);
}
