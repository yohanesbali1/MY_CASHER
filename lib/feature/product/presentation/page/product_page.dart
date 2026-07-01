import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/widgets/action_button_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/item_base_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        spacing: 12,
                        children: List.generate(state.products_data.length, (
                          index,
                        ) {
                          return ItemBaseWidget(
                            product_item: state.products_data[index],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              ActionButtonWidget(),
            ],
          ),
        );
      },
    );
  }
}
