import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/bloc/transaction_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/widget/dashboard_summary_widget.dart';
import 'package:my_casher/feature/transaction/persentation/widget/modal_filter_transaction_widget.dart';
import 'package:my_casher/feature/transaction/persentation/widget/recent_transaction_base_widget.dart';
import 'package:my_casher/feature/transaction/persentation/widget/transaction_filter_widget.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> showDateFilterModal({
      required BuildContext context,
      required DateTime? from,
      required DateTime? to,
      required Function(DateTime? from, DateTime? to) onApply,
    }) async {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) =>
            ModalFilterTransactionWidget(from: from, to: to, onApply: onApply),
      );
    }

    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(
            title: 'Histori Transaksi',
            showBackButton: false,
          ),
          body: Column(
            children: [
              TransactionFilterWidget(
                startDate: state.startDate,
                endDate: state.endDate,
                onFilter: () async {
                  await showDateFilterModal(
                    context: context,
                    from: state.startDate,
                    to: state.endDate,
                    onApply: (from, to) {
                      // context.read<TransactionBloc>().add(
                      //   FilterTransactionEvent(startDate: from, endDate: to),
                      // );
                    },
                  );
                },
                onReset: () {
                  // context.read<TransactionBloc>().add(
                  //   const FilterTransactionEvent(
                  //     startDate: null,
                  //     endDate: null,
                  //   ),
                  // );
                },
              ),

              const SizedBox(height: 16),

              DashboardSummaryWidget(
                totalRevenue: state.totalRevenue,
                totalTransaction: state.totalTransaction,
                totalItem: state.totalItem,
              ),

              const SizedBox(height: 16),

              Expanded(
                child: RecentTransactionBaseWidget(
                  transactions: state.transactionData,
                  hasReachedMax: state.hasReachedMax,
                  isLoading: state.isLoading,
                  isLoadingMore: state.isLoadingMore,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
