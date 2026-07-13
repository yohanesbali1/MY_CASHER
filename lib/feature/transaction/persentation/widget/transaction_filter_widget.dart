import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionFilterWidget extends StatelessWidget {
  const TransactionFilterWidget({
    super.key,
    this.startDate,
    this.endDate,
    required this.onFilter,
    required this.onReset,
  });

  final DateTime? startDate;
  final DateTime? endDate;

  final VoidCallback onFilter;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final divider = Theme.of(context).dividerColor;

    final isFiltered = startDate != null || endDate != null;

    final format = DateFormat("dd/MM/yyyy");

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: divider)),
      ),
      child: Row(
        children: [
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: onFilter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isFiltered
                      ? color.primary.withOpacity(.08)
                      : color.secondary,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isFiltered
                        ? color.primary.withOpacity(.25)
                        : divider,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      size: 18,
                      color: isFiltered
                          ? color.primary
                          : color.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        isFiltered
                            ? "${startDate != null ? format.format(startDate!) : "..."} — "
                                  "${endDate != null ? format.format(endDate!) : "..."}"
                            : "Semua tanggal",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isFiltered
                              ? color.primary
                              : color.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isFiltered) ...[
            const SizedBox(width: 8),

            InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: onReset,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.secondary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: divider),
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 18,
                  color: color.onSurfaceVariant,
                ),
              ),
            ),
          ],

          const SizedBox(width: 8),

          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onFilter,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.secondary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: divider),
              ),
              child: Icon(
                Icons.filter_alt_outlined,
                size: 18,
                color: color.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
