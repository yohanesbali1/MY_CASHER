import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 48),
          SizedBox(height: 8),
          Text("Keranjang kosong"),
        ],
      ),
    );
  }
}
