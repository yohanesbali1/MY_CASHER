import 'package:flutter/material.dart';

class QrisWaitingWidget extends StatelessWidget {
  const QrisWaitingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: .3, end: 1),
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
          builder: (context, value, child) {
            return AnimatedOpacity(
              opacity: value,
              duration: const Duration(milliseconds: 900),
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color.primary,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
          onEnd: () {},
        ),

        const SizedBox(width: 10),

        Text(
          'Menunggu konfirmasi pembayaran...',
          style: text.bodyMedium?.copyWith(
            color: color.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
