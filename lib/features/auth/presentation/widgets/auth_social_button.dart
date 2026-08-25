import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.isLoading = false,
    this.height = 42,
    this.foregroundColor = AppColors.ink,
    this.borderColor = AppColors.divider,
    this.backgroundColor = AppColors.white,
  });
  final String label;
  final VoidCallback? onPressed;
  final Widget icon;
  final bool isLoading;
  final double height;
  final Color foregroundColor;
  final Color borderColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: isLoading
          ? const SizedBox.square(
              dimension: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : icon,
      label: Text(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: BorderSide(color: borderColor),
        shape: const RoundedRectangleBorder(),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

class GoogleMark extends StatelessWidget {
  const GoogleMark({super.key, this.size = 20});
  final double size;
  @override
  Widget build(BuildContext context) => Text(
    'G',
    style: TextStyle(
      color: const Color(0xFF4285F4),
      fontSize: size,
      height: 1,
      fontWeight: FontWeight.w700,
      fontFamily: 'Arial',
    ),
  );
}
