import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart_bottom_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/product_grid_widget.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class PosPage extends StatelessWidget {
  const PosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(title: 'Kasir'),
          body: RefreshIndicator(
            onRefresh: () async {
              context.read<PosBloc>().add(PosStarted());
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProductGridWidget(
                            products: state.products_data,
                            cart: state.cartItems,
                            onTap: (product) {},
                          ),
                          CartBottomWidget(cart: state.cartItems),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
