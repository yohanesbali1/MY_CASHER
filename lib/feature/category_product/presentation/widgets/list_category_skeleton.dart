import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ListCategorySkeleton extends StatelessWidget {
  const ListCategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(
              children: [
                const Bone.square(
                  size: 32,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Bone.text(words: 2, fontSize: 16),
                      SizedBox(height: 8),
                      Bone.text(words: 1, fontSize: 12),
                    ],
                  ),
                ),

                const SizedBox(width: 12),
                const Bone.square(
                  size: 28,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),

                const SizedBox(width: 12),

                const Bone.square(
                  size: 28,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
