import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';

class AuthSocialButton extends StatelessWidget {
  const AuthSocialButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    this.height = 42,
    this.foregroundColor = AppColors.ink,
    this.borderColor = AppColors.divider,
    this.backgroundColor = AppColors.white,
  });
  final String label;
  final VoidCallback? onPressed;
  final Widget icon;
  final double height;
  final Color foregroundColor;
  final Color borderColor;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) => SizedBox(
    height: height,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      icon: icon,
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

class LinkedInMark extends StatelessWidget {
  const LinkedInMark({
    super.key,
    this.size = 20,
    this.color = AppColors.linkedIn,
  });
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(2),
    ),
    child: Text(
      'in',
      style: TextStyle(
        color: Colors.white,
        fontSize: size * .75,
        height: 1,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
      ),
    ),
  );
}
