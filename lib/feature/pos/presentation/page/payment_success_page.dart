import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({
    super.key,
    required this.isCash,
    required this.change,
  });

  final bool isCash;
  final double change;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppAppBar(
        title: 'Pembayaran Berhasil',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: color.primary.withValues(alpha: .12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_rounded,
                  color: color.primary,
                  size: 52,
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Pembayaran Berhasil!",
                style: text.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              if (isCash)
                Text(
                  "Kembalian",
                  style: text.bodyMedium?.copyWith(
                    color: color.onSurfaceVariant,
                  ),
                ),

              if (isCash) const SizedBox(height: 4),

              if (isCash)
                Text(
                  CurrencyHelper.rupiah(change),
                  style: text.headlineSmall?.copyWith(
                    color: color.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              if (!isCash)
                Text(
                  "Pembayaran QRIS telah berhasil dikonfirmasi.",
                  textAlign: TextAlign.center,
                  style: text.bodyMedium?.copyWith(
                    color: color.onSurfaceVariant,
                  ),
                ),

              const Spacer(),

              FilledButton.icon(
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: () {
                  // TODO : Cetak Struk
                },
                icon: const Icon(Icons.print_rounded),
                label: Text(
                  "Cetak Struk",
                  style: text.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 12),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: color.surface,
                  minimumSize: const Size.fromHeight(52),
                ),
                onPressed: () {
                  context.go('/pos');
                },
                icon: const Icon(
                  Icons.point_of_sale_rounded,
                  color: Colors.green,
                ),
                label: Text(
                  "Transaksi Baru",
                  style: text.bodyMedium?.copyWith(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
