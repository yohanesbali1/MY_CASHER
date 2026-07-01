import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.enabled = true,
    this.autofocus = false,
    this.obscureText = false,
    this.inputFormatters,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final String? hintText;
  final String? labelText;
  final String? errorText;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final int maxLines;

  final bool enabled;
  final bool autofocus;
  final bool obscureText;

  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return TextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      autofocus: autofocus,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      onSubmitted: onSubmitted,
      style: text.bodyMedium?.copyWith(color: color.onSurface, fontSize: 14),
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        isDense: true,

        filled: true,
        fillColor: color.secondary,

        hintStyle: text.bodyMedium?.copyWith(
          color: color.onSecondary.withValues(alpha: .7),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color.primary, width: 1.4),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color.error),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color.error, width: 1.4),
        ),
      ),
    );
  }
}
