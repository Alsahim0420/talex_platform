import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/constants/app_assets.dart';
import 'package:talex_platform/core/widgets/talex_logo.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({
    super.key,
    this.logoAsset = AppAssets.talexLogoHorizontal,
    this.subtitle = 'Enterprise Logic',
    this.logoWidth = 250,
    this.logoHeight = 72,
    this.subtitleStyle,
    this.spacing = 8,
    this.semanticLabel = 'TaleX',
  });
  final String logoAsset;
  final String subtitle;
  final double logoWidth;
  final double logoHeight;
  final TextStyle? subtitleStyle;
  final double spacing;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      TalexLogo(
        width: logoWidth,
        height: logoHeight,
        semanticLabel: semanticLabel,
        asset: logoAsset,
      ),
      SizedBox(height: spacing),
      Text(
        subtitle,
        textAlign: TextAlign.center,
        style:
            subtitleStyle ??
            const TextStyle(
              color: AppColors.subtitle,
              fontSize: 16,
              height: 1.25,
            ),
      ),
    ],
  );
}
