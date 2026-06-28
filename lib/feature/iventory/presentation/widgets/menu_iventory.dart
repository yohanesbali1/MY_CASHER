import 'package:flutter/material.dart';

class MenuInventory extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const MenuInventory({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  static const items = [
    (icon: Icons.inventory_2_outlined, label: 'Inventaris'),
    (icon: Icons.bar_chart_outlined, label: 'Statistik'),
    (icon: Icons.sell_outlined, label: 'Kategori'),
  ];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = constraints.maxWidth / items.length;

          return Container(
            height: 48,
            decoration: BoxDecoration(
              color: color.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                /// Background aktif yang bergeser
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  left: currentIndex * itemWidth,
                  top: 4,
                  bottom: 4,
                  child: Container(
                    width: itemWidth,
                    decoration: BoxDecoration(
                      color: color.surface,
                      borderRadius: BorderRadius.circular(10),
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
                    final selected = index == currentIndex;

                    return Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => onChanged(index),
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
