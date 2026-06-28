import 'package:flutter/material.dart';

class ActionFormButtonWidget extends StatelessWidget {
  const ActionFormButtonWidget({super.key, this.onSave, this.onCancel});

  final VoidCallback? onSave;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _button(
            context,
            text: 'Simpan',
            backgroundColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onTap: onSave,
          ),
        ),
        Expanded(
          child: _button(
            context,
            text: 'Batal',
            backgroundColor: Theme.of(context).colorScheme.secondary,
            textColor: Theme.of(context).colorScheme.onSecondary,
            onTap: onCancel,
          ),
        ),
      ],
    );
  }

  Widget _button(
    BuildContext context, {
    required String text,
    required Color backgroundColor,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    final text_style = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            text,
            style: text_style.bodyMedium!.copyWith(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
