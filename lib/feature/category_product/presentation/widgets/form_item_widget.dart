import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/bloc/category_product_bloc.dart';
import 'package:my_casher/feature/category_product/presentation/widgets/action_form_button_widget.dart';
import 'package:my_casher/shared/widget/form/form_widget.dart';

class FormItemWidget extends StatefulWidget {
  const FormItemWidget({super.key});

  @override
  State<FormItemWidget> createState() => _FormItemWidgetState();
}

class _FormItemWidgetState extends State<FormItemWidget> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();

    final state = context.read<CategoryProductBloc>().state;
    _nameController.text = state.name;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryProductBloc, CategoryProductState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            AppTextField(
              onChanged: (value) {
                context.read<CategoryProductBloc>().add(
                  CategoryFieldChanged(field: CategoryField.name, value: value),
                );
              },
              controller: _nameController,
              errorText: state.nameError,
              hintText: 'Nama kategori..',
              enabled: state.isLoading == false,
            ),
            ActionFormButtonWidget(
              onSave: () {
                if (state?.status == FormMode.create) {
                  context.read<CategoryProductBloc>().add(
                    CategoryProductCreate(),
                  );
                }
                if (state?.status == FormMode.update) {
                  context.read<CategoryProductBloc>().add(
                    CategoryProductUpdate(),
                  );
                }
                return;
              },
              onCancel: () {
                context.read<CategoryProductBloc>().add(
                  const CategoryModeChange(FormMode.list),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
