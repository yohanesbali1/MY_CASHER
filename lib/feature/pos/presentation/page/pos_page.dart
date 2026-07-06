import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart_bottom_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/product_grid_widget.dart';

class PosPage extends StatelessWidget {
  PosPage({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 180),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        context.read<PosBloc>().add(PosStarted());
                      },
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

                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 16,
                    child: CartBottomWidget(
                      total: state.total,
                      totalItems: state.totalItem,
                      onTap: () => {controller.jumpToPage(1)},
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
