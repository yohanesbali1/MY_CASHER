import 'package:flutter/material.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/payment_panel_widget.dart';

// import 'payment_panel_widget.dart';

class PaymentMethodWidget extends StatelessWidget {
  const PaymentMethodWidget({
    super.key,
    required this.method,
    required this.onChanged,
  });

  final PaymentMethod method;

  final ValueChanged<PaymentMethod> onChanged;

  static const items = [
    (icon: Icons.payments, label: 'Tunai', value: PaymentMethod.cash),
    (icon: Icons.qr_code, label: 'Qr', value: PaymentMethod.qris),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 8) / items.length;
          final index = items.indexWhere((e) => e.value == method);
          return Container(
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: index * itemWidth,
                  top: 4,
                  bottom: 4,
                  child: Container(
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: color.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: .06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Menu
                Row(
                  children: List.generate(items.length, (index) {
                    final item = items[index];
                    final selected = method == item.value;

                    return Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => onChanged(item.value),
                        child: SizedBox(
                          height: 48,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item.icon,
                                size: 16,
                                color: selected
                                    ? color.onSurface
                                    : color.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                item.label,
                                style: text.labelSmall?.copyWith(
                                  color: selected
                                      ? color.onSurface
                                      : color.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
