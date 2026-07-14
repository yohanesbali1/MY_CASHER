import 'package:flutter/material.dart';
import 'package:my_casher/feature/transaction/data/model/transaction_model.dart';
import 'package:my_casher/feature/transaction/persentation/widget/transaction_item_widget.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({
    super.key,
    required this.transactions,
    required this.controller,
    required this.hasReachedMax,
    required this.isLoading,
    required this.isLoadingMore,
    required this.onTap,
  });

  final List<TransactionModel> transactions;
  final ScrollController controller;
  final bool hasReachedMax;
  final bool isLoading;
  final bool isLoadingMore;
  final Function(TransactionModel) onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    if (isLoading && transactions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (transactions.isEmpty) {
      return ListView(
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text("Belum ada transaksi", style: text.bodySmall),
            ),
          ),
        ],
      );
    }

    return ListView.builder(
      controller: controller,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: transactions.length + (hasReachedMax ? 0 : 1),
      itemBuilder: (context, index) {
        if (index == transactions.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Center(
              child: AnimatedOpacity(
                opacity: isLoadingMore ? 1 : 0,
                duration: const Duration(milliseconds: 250),
                child: const SizedBox(
                  width: 26,
                  height: 26,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ),
            ),
          );
        }

        final transaction = transactions[index];

        return GestureDetector(
          onTap: () => onTap(transaction),
          child: TransactionItemWidget(item: transaction),
        );
      },
    );
  }
}
