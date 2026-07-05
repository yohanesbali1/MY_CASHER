import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductListSkeleton extends StatelessWidget {
  const ProductListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: 8,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Row(
              children: [
                const Bone.square(
                  size: 56,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Bone.text(width: 160),
                      SizedBox(height: 8),
                      Bone.text(width: 70),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Bone.text(width: 70),
                    SizedBox(height: 8),
                    Bone.text(width: 70),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
