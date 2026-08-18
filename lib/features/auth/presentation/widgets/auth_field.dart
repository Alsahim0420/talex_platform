import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';

class AuthField extends StatelessWidget {
  const AuthField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
    this.label,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSubmitted,
    this.height = 43,
    this.iconColor = AppColors.muted,
    this.borderColor = AppColors.border,
    this.focusedBorderColor = AppColors.ink,
    this.fillColor,
    this.textStyle,
    this.hintStyle,
    this.decoration,
  });
  final TextEditingController controller;
  final String hint;
  final IconData? icon;
  final String? label;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;
  final double height;
  final Color iconColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color? fillColor;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      style: textStyle ?? const TextStyle(color: AppColors.ink, fontSize: 15),
      decoration:
          decoration ??
          InputDecoration(
            labelText: label,
            hintText: hint,
            hintStyle:
                hintStyle ??
                const TextStyle(color: AppColors.muted, fontSize: 15),
            prefixIcon: icon == null
                ? null
                : Icon(icon, color: iconColor, size: 21),
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(vertical: 11),
            border: _border(borderColor),
            enabledBorder: _border(borderColor),
            focusedBorder: _border(focusedBorderColor, 1.2),
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
    ),
  );

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: color, width: width),
      );
}

class AuthFieldLabel extends StatelessWidget {
  const AuthFieldLabel(this.text, {super.key, this.style});
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) => Text(
    text,
    style:
        style ??
        const TextStyle(
          color: AppColors.ink,
          fontSize: 15,
          height: 1.2,
          fontWeight: FontWeight.w600,
        ),
  );
}
