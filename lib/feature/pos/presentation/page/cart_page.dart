import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/pos/presentation/bloc/pos_bloc.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart/cart_header_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart/cart_list_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/cart/empty_cart_widget.dart';
import 'package:my_casher/feature/pos/presentation/widget/payment/payment_panel_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PosBloc, PosState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CartHeaderWidget(controller: controller),

                Expanded(
                  child: state.cartItems.isEmpty
                      ? const EmptyCartWidget()
                      : CartListWidget(items: state.cartItems),
                ),

                if (state.cartItems.isNotEmpty)
                  PaymentPanelWidget(
                    cart: state.cartItems,
                    total: state.total,
                    totalItem: state.totalItem,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
