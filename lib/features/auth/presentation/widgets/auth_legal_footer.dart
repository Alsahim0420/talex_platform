import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';

class AuthLegalFooter extends StatelessWidget {
  const AuthLegalFooter({
    super.key,
    this.privacyText = 'Privacy Policy',
    this.termsText = 'Terms of Service',
    this.onPrivacyPressed,
    this.onTermsPressed,
    this.textStyle,
    this.separator = '•',
    this.spacing = 23,
  });
  final String privacyText;
  final String termsText;
  final VoidCallback? onPrivacyPressed;
  final VoidCallback? onTermsPressed;
  final TextStyle? textStyle;
  final String separator;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    final style =
        textStyle ??
        const TextStyle(
          color: AppColors.legalText,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        );
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        TextButton(
          onPressed: onPrivacyPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            textStyle: style,
            foregroundColor: style.color,
          ),
          child: Text(privacyText),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(
            separator,
            style: const TextStyle(color: AppColors.softBorder),
          ),
        ),
        TextButton(
          onPressed: onTermsPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            textStyle: style,
            foregroundColor: style.color,
          ),
          child: Text(termsText),
        ),
      ],
    );
  }
}
