import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductListEmptyWidget extends StatelessWidget {
  const ProductListEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      height: 350,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: color.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 42,
                color: color.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Belum Ada Produk',
              style: text.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Tambahkan produk baru untuk mulai\nmengelola inventori.',
              textAlign: TextAlign.center,
              style: text.bodyMedium?.copyWith(color: color.outline),
            ),
          ],
        ),
      ),
    );
  }
}
