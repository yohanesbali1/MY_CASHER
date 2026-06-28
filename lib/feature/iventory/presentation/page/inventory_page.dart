import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/page/category_product_page.dart';
import 'package:my_casher/feature/iventory/presentation/bloc/iventory_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/widgets/menu_iventory.dart';
import 'package:my_casher/shared/widget/app_bar/app_app_bar.dart';

class InventoryPage extends StatelessWidget {
  InventoryPage({super.key});

  final controller = PageController();

  final pages = [CategoryProductPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IventoryBloc, IventoryState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const AppAppBar(title: 'Inventory'),
          body: Column(
            children: [
              MenuInventory(
                currentIndex: state.currentIndex,
                onChanged: (index) {
                  context.read<IventoryBloc>().add(IventoryTabChanged(index));
                },
              ),
              Expanded(
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    context.read<IventoryBloc>().add(IventoryTabChanged(index));
                  },
                  children: pages,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
