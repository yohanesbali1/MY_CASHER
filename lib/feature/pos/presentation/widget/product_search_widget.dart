import 'package:flutter/material.dart';
import 'package:my_casher/shared/widget/form/form_widget.dart';

class ProductSearchWidget extends StatefulWidget {
  const ProductSearchWidget({super.key, this.search, this.onSearch});

  final String? search;
  final Function(String)? onSearch;
  @override
  State<ProductSearchWidget> createState() => _ProductSearchWidgetState();
}

class _ProductSearchWidgetState extends State<ProductSearchWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
    controller.text = '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: double.infinity,
      child: AppTextField(
        controller: controller,
        keyboardType: TextInputType.number,
        hintText: 'Cari produk...',
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(
                  Icons.close_rounded,
                  color: Colors.black.withValues(alpha: .5),
                  size: 20,
                ),
                onPressed: () {
                  controller.clear();
                  widget.onSearch!('');
                },
              ),

        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 2),
          child: Icon(
            Icons.search_rounded,
            color: Colors.black.withValues(alpha: .5),
            size: 20,
          ),
        ),
        onChanged: (value) {
          if (widget.onSearch != null) {
            widget.onSearch!(value);
          }
        },
      ),
    );
  }
}
