import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_assets.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/constants/app_radii.dart';
import 'package:talex_platform/core/widgets/language_selector.dart';

class TalexAuthFrame extends StatelessWidget {
  const TalexAuthFrame({
    super.key,
    required this.title,
    required this.child,
    this.maxWidth = 680,
    this.showBack = true,
    this.onBack,
  });

  final String title;
  final Widget child;
  final double maxWidth;
  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Material(
                color: Colors.white,
                elevation: 12,
                shadowColor: AppColors.ink.withValues(alpha: 0.12),
                borderRadius: AppRadii.border,
                clipBehavior: Clip.antiAlias,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(8, 8, 16, 18),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.ink, Color(0xFF0A1F40)],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              if (showBack &&
                                  (onBack != null ||
                                      Navigator.of(context).canPop()))
                                IconButton(
                                  onPressed:
                                      onBack ??
                                      () => Navigator.of(context).pop(),
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                )
                              else
                                const SizedBox(width: 48),
                              Expanded(
                                child: Image.asset(
                                  AppAssets.talexBadgeDark,
                                  height: 52,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const LanguageSelector(compact: true),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 14),
                          const Row(
                            children: [
                              Expanded(
                                child: ColoredBox(
                                  color: AppColors.brandBlue,
                                  child: SizedBox(height: 3),
                                ),
                              ),
                              Expanded(
                                child: ColoredBox(
                                  color: AppColors.brandGreen,
                                  child: SizedBox(height: 3),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          child,
                          const SizedBox(height: 24),
                          Image.asset(AppAssets.talexMarca, fit: BoxFit.fitWidth),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
