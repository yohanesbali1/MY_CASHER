import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 48,
            color: Colors.black.withValues(alpha: .5),
          ),
          SizedBox(height: 8),
          Text(
            "Keranjang kosong",
            style: text.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black.withValues(alpha: .5),
            ),
          ),
        ],
      ),
    );
  }
}
