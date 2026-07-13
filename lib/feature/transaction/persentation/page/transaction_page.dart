import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/bloc/transaction_bloc.dart';
import 'package:my_casher/feature/transaction/persentation/widget/dashboard_summary_widget.dart';
import 'package:my_casher/feature/transaction/persentation/widget/recent_transaction_base_widget.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(
            title: 'Histori Transaksi',
            showBackButton: false,
          ),
          body: Column(
            children: [
              DashboardSummaryWidget(
                totalRevenue: 0,
                totalTransaction: 0,
                totalItem: 0,
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
