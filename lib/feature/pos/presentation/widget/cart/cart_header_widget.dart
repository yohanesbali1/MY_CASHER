import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartHeaderWidget extends StatelessWidget {
  const CartHeaderWidget({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: color.surface,
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => {controller.jumpToPage(0)},
            icon: const Icon(Icons.chevron_left),
          ),
          Text(
            "Keranjang",
            style: text.titleMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
