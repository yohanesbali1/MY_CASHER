import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/feature/product/presentation/widgets/action_button_widget.dart';
import 'package:my_casher/feature/product/presentation/widgets/product_list_widget.dart';

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
                child: ProductListWidget(
                  isLoading: state.isLoading,
                  products: state.products_data,
                  onRefresh: () async {
                    context.read<ProductBloc>().add(ProductLoad());
                  },
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
