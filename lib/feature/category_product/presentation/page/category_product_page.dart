import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/action_button_widget.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/custome_item_widget.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/list_cateogory_widget.dart';
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
                child: ListCategoryWidget(
                  isLoading: state.isLoading,
                  categories: state.data,
                  status: state.status,
                  selectedId: state.id,
                  onRefresh: () async {
                    context.read<CategoryProductBloc>().add(
                      CategoryProductStarted(),
                    );
                  },
                  onDelete: (category) {
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
                          CategoryProductDelete(category.id!),
                        );
                      },
                    );
                  },
                  onEdit: (category) {
                    context.read<CategoryProductBloc>().add(
                      CategoryShowData(category.id!),
                    );
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
