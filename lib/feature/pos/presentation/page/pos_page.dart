import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart_bottom_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/category_filter_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/product_grid_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/product_search_widget.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ProductSearchWidget(
                      search: state.searchProduct,
                      onSearch: (search) {
                        context.read<PosBloc>().add(
                          SearchProduct(search: search),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CategoryFilterWidget(
                      categories: state.category_data,
                      selected: state.selectedCategory,
                      onSelected: (category) {
                        context.read<PosBloc>().add(
                          SelectCategory(category_id: category),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: CustomRefreshIndicator(
                      onRefresh: () async {
                        context.read<PosBloc>().add(PosStarted());

                        await context.read<PosBloc>().stream.firstWhere(
                          (state) => !state.isLoading,
                        );
                      },
                      builder: (context, child, controller) {
                        final offset = controller.value * 60;

                        return Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    value: controller.isLoading
                                        ? null
                                        : controller.value.toDouble(),
                                  ),
                                ),
                              ),
                            ),

                            Transform.translate(
                              offset: Offset(0, offset),
                              child: child,
                            ),
                          ],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 180),
                        child: ProductGridWidget(
                          products: state.products_data,
                          cart: state.cartItems,
                          onTap: (product) {
                            context.read<PosBloc>().add(
                              AddProductToCart(product: product),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: CartBottomWidget(
                  total: state.total,
                  totalItems: state.totalItem,
                  onTap: () {
                    controller.jumpToPage(1);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
