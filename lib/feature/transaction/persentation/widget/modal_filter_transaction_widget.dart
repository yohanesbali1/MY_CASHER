import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ModalFilterTransactionWidget extends StatefulWidget {
  const ModalFilterTransactionWidget({
    super.key,
    required this.from,
    required this.to,
    required this.onApply,
  });

  final DateTime? from;
  final DateTime? to;
  final Function(DateTime?, DateTime?) onApply;

  @override
  State<ModalFilterTransactionWidget> createState() =>
      _ModalFilterTransactionWidgetState();
}

class _ModalFilterTransactionWidgetState
    extends State<ModalFilterTransactionWidget> {
  DateTime? from;
  DateTime? to;

  String? selectedPreset;

  String? error;

  @override
  void initState() {
    super.initState();
    from = widget.from;
    to = widget.to;
  }

  Future<void> pickFrom() async {
    final result = await showDatePicker(
      context: context,
      initialDate: from ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: to ?? DateTime.now(),
    );

    if (result != null) {
      setState(() {
        from = result;
        error = null;
      });
    }
  }

  Future<void> pickTo() async {
    final result = await showDatePicker(
      context: context,
      initialDate: to ?? DateTime.now(),
      firstDate: from ?? DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (result != null) {
      setState(() {
        to = result;
        error = null;
      });
    }
  }

  void presetToday() {
    final now = DateTime.now();

    setState(() {
      from = DateTime(now.year, now.month, now.day);
      to = DateTime(now.year, now.month, now.day);
      selectedPreset = "Today";
    });
  }

  void preset7Days() {
    final now = DateTime.now();

    setState(() {
      from = now.subtract(const Duration(days: 6));
      to = now;
      selectedPreset = "7 Days";
    });
  }

  void preset30Days() {
    final now = DateTime.now();

    setState(() {
      from = now.subtract(const Duration(days: 29));
      to = now;
      selectedPreset = "30 Days";
    });
  }

  void presetMonth() {
    final now = DateTime.now();

    setState(() {
      from = DateTime(now.year, now.month, 1);
      to = now;
      selectedPreset = "This Month";
    });
  }

  String format(DateTime? date) {
    if (date == null) return "Pilih";
    return DateFormat("dd/MM/yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        bottom: 16 + MediaQuery.viewPaddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(50),
            ),
          ),

          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Icon(Icons.calendar_month, size: 18),
                const SizedBox(width: 8),
                Text("Filter Tanggal", style: text.titleMedium),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          Divider(height: 1, color: Colors.grey.withValues(alpha: .2)),

          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _FilterButton(
                    "Hari Ini",
                    presetToday,
                    selected: selectedPreset == "Today",
                  ),
                  _FilterButton(
                    "7 Hari",
                    preset7Days,
                    selected: selectedPreset == "7 Days",
                  ),
                  _FilterButton(
                    "30 Hari",
                    preset30Days,
                    selected: selectedPreset == "30 Days",
                  ),
                  _FilterButton(
                    "Bulan Ini",
                    presetMonth,
                    selected: selectedPreset == "This Month",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        "Tanggal Awal",
                        style: text.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withValues(alpha: .5),
                        ),
                      ),
                      _ButtonDate(label: format(from), onTap: pickFrom),
                    ],
                  ),
                ),

                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 5,
                    children: [
                      Text(
                        "Tanggal Akhir",
                        style: text.labelMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withValues(alpha: .5),
                        ),
                      ),
                      _ButtonDate(label: format(to), onTap: pickTo),
                    ],
                  ),
                ),
              ],
            ),
          ),

          if (error != null) ...[
            const SizedBox(height: 12),
            Text(error!, style: text.bodySmall?.copyWith(color: Colors.red)),
          ],

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: () {
                      widget.onApply(null, null);
                      Navigator.pop(context);
                    },
                    child: const Text("Reset"),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (from != null && to != null && from!.isAfter(to!)) {
                        setState(() {
                          error =
                              "Tanggal awal tidak boleh melebihi tanggal akhir";
                        });
                        return;
                      }

                      widget.onApply(from, to);

                      Navigator.pop(context);
                    },
                    child: const Text("Terapkan"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _FilterButton(
    String label,
    VoidCallback onTap, {
    bool selected = false,
  }) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return FilterChip(
      label: Text(
        "$label",
        style: text.bodyMedium?.copyWith(
          fontSize: 12,
          color: selected
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onSecondary,
        ),
      ),
      onSelected: (_) => onTap(),
      showCheckmark: false,
      selected: selected,
      backgroundColor: color.secondary,
      selectedColor: color.primary,
      side: BorderSide(
        color: selected ? color.primary : Theme.of(context).dividerColor,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: -2, vertical: -2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    );
  }

  Widget _ButtonDate({required String label, required VoidCallback onTap}) {
    final text = Theme.of(context).textTheme;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          children: [
            Expanded(child: Text(label, style: text.bodySmall?.copyWith())),
            Icon(
              Icons.calendar_today_outlined,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
