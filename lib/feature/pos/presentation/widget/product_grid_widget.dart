import 'package:flutter/material.dart';
import 'package:my_casher/core/helpers/currency_helper.dart';
import 'package:my_casher/feature/pos/data/models/cart_item_model.dart';
import 'package:my_casher/feature/product/data/models/product_models.dart';
import 'package:my_casher/shared/widget/empty/empty_widget.dart';

class ProductGridWidget extends StatelessWidget {
  const ProductGridWidget({
    super.key,
    required this.products,
    required this.cart,
    required this.onTap,
  });

  final List<ProductModels> products;
  final List<CartItemModel> cart;
  final void Function(ProductModels product) onTap;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = width >= 600 ? 3 : 2;
    if (products.isEmpty) {
      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: EmptyStateWidget(
              icon: Icons.inventory_2_outlined,
              title: 'Produk Tidak Ditemukan',
              description:
                  'Silahkan refresh halaman ini\nuntuk menampilkan produk.',
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      // shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: crossAxisCount == 2 ? 1.2 : 1.5,
      ),
      itemBuilder: (context, index) {
        final product = products[index];

        final cartItem = cart.cast<CartItemModel?>().firstWhere(
          (e) => e?.product.id == product.id,
          orElse: () => null,
        );

        final inCart = cartItem != null;
        final outOfStock = product.quantity == 0;

        return InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: outOfStock ? null : () => onTap(product),
          splashColor: Colors.transparent,
          child: Opacity(
            opacity: outOfStock ? .45 : 1,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: inCart
                        ? color.primary.withValues(alpha: .08)
                        : color.surface,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: inCart
                          ? color.primary
                          : Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Text(
                              product.icon ?? "📦",
                              style: const TextStyle(fontSize: 36),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        "${product.name}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: text.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        CurrencyHelper.rupiah(product.price),
                        style: text.labelMedium?.copyWith(
                          color: color.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        "Stok: ${product.quantity}",
                        style: text.labelSmall?.copyWith(
                          color: product.quantity <= 5
                              ? color.error
                              : color.onSurfaceVariant,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                if (inCart)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: color.primary,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        cartItem.quantity.toString(),
                        style: text.labelSmall?.copyWith(
                          color: color.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
