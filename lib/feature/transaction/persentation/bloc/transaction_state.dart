part of 'transaction_bloc.dart';

@immutable
class TransactionState {
  final List<TransactionModel> transactionData;

  final int page;
  final bool hasReachedMax;
  final bool isLoading;
  final bool isLoadingMore;

  final String search;
  final DateTime? startDate;
  final DateTime? endDate;

  final double totalRevenue;
  final int totalItem;
  final int totalTransaction;

  static const _unset = Object();

  const TransactionState({
    this.transactionData = const [],
    this.page = 1,
    this.hasReachedMax = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.search = '',
    this.startDate,
    this.endDate,
    this.totalRevenue = 0,
    this.totalItem = 0,
    this.totalTransaction = 0,
  });

  TransactionState copyWith({
    List<TransactionModel>? data,
    int? page,
    bool? hasReachedMax,
    bool? isLoading,
    bool? isLoadingMore,
    Object? search = _unset,
    Object? startDate = _unset,
    Object? endDate = _unset,
    double? totalRevenue,
    int? totalItem,
    int? totalTransaction,
  }) {
    return TransactionState(
      transactionData: data ?? transactionData,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      search: search == _unset ? this.search : (search as String? ?? ''),
      startDate: startDate == _unset ? this.startDate : startDate as DateTime?,
      endDate: endDate == _unset ? this.endDate : endDate as DateTime?,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      totalItem: totalItem ?? this.totalItem,
      totalTransaction: totalTransaction ?? this.totalTransaction,
    );
  }
}
