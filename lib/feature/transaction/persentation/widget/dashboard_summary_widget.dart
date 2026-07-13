import 'package:flutter/material.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';

class DashboardSummaryWidget extends StatelessWidget {
  const DashboardSummaryWidget({
    super.key,
    required this.totalRevenue,
    required this.totalTransaction,
    required this.totalItem,
  });

  final double totalRevenue;
  final int totalTransaction;
  final int totalItem;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    Widget card({
      required String title,
      required String value,
      required String subtitle,
      Color? valueColor,
    }) {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.toUpperCase(), style: text.labelSmall),
              const SizedBox(height: 6),
              Text(
                value,
                style: text.titleLarge?.copyWith(
                  color: valueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: text.bodySmall),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          card(
            title: "Total Penjualan",
            value: CurrencyHelper.rupiah(totalRevenue),
            subtitle: "$totalTransaction transaksi",
            valueColor: color.primary,
          ),
          card(title: "Item Terjual", value: "$totalItem", subtitle: "unit"),
        ],
      ),
    );
  }
}
