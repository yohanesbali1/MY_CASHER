import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/home/presentation/bloc/home_bloc.dart';
import 'package:my_casher/feature/iventory/presentation/page/inventory_page.dart';
import 'package:my_casher/feature/home/presentation/page/pos_page.dart';
import 'package:my_casher/feature/home/presentation/widgets/home_bottom_navigation.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final controller = PageController();

  final pages = [PosPage(), InventoryPage()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              context.read<HomeBloc>().add(HomeTabChanged(index));
            },
            children: pages,
          ),
          bottomNavigationBar: HomeBottomNavigation(
            currentIndex: state.currentIndex,
            onTap: (index) {
              controller.jumpToPage(index);
              context.read<HomeBloc>().add(HomeTabChanged(index));
            },
          ),
        );
      },
    );
  }
}
