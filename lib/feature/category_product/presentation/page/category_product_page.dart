import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/action_button_widget.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/custome_item_widget.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/item_category.dart';
import 'package:my_casher/shared/widget/modal/confirmation_modal.dart';

class CategoryProductPage extends StatelessWidget {
  const CategoryProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 12,
            children: [
              if (state?.status == FormMode.create) CustomeItemWidget(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {},
                  child: ScrollConfiguration(
                    behavior: ScrollBehavior().copyWith(overscroll: false),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        spacing: 12,
                        children: List.generate(state.data.length, (index) {
                          if (state.id == state.data[index].id &&
                              state.status == FormMode.update) {
                            return CustomeItemWidget();
                          }

                          return ItemCategoryWidget(
                            name: state.data[index].name,
                            count: 0,
                            isEdit: state.data[index].isEdit,
                            onDelete: () {
                              context.read<CategoryProductBloc>().add(
                                CategoryModeChange(FormMode.list),
                              );
                              showConfirmBottomSheet(
                                context,
                                title: 'Hapus kategori',
                                message:
                                    'Apakah Anda yakin ingin menghapus kategori ini?',
                                danger: true,
                                onConfirm: () {
                                  context.read<CategoryProductBloc>().add(
                                    CategoryProductDelete(state.data[index].id),
                                  );
                                },
                              );
                            },
                            onEdit: () {
                              context.read<CategoryProductBloc>().add(
                                CategoryShowData(state.data[index].id),
                              );
                            },
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
