import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_assets.dart';
import 'package:talex_platform/core/widgets/talex_logo.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({
    super.key,
    this.logoAsset = AppAssets.talexLogoHorizontal,
    this.logoWidth = 250,
    this.logoHeight = 72,
    this.semanticLabel = 'TaleX',
  });
  final String logoAsset;
  final double logoWidth;
  final double logoHeight;
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
    ],
  );
}
