import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_casher/feature/product/presentation/bloc/product_bloc.dart';
import 'package:my_casher/shared/widget/modal/confirmation_modal.dart';

class HeaderItemUpdateWidget extends StatelessWidget {
  const HeaderItemUpdateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Row(
          children: [
            // ProductImageWidget(image: image, size: 42),
            const SizedBox(width: 10),

            Expanded(
              child: Text(
                "${state.show_product_data?.name}",
                style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),

            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                showConfirmBottomSheet(
                  context,
                  title: 'Hapus Produk',
                  message: 'Apakah Anda yakin ingin menghapus produk ini?',
                  danger: true,
                  onConfirm: () {
                    context.read<ProductBloc>().add(
                      ProductDelete(id: state.show_product_data?.id ?? 0),
                    );
                  },
                );
              },
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color.error.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.delete_outline, color: color.error, size: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}
