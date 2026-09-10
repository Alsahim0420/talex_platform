import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/constants/app_radii.dart';
import 'package:talex_platform/features/talent/domain/entities/talent_entities.dart';
import 'package:talex_platform/l10n/l10n.dart';

class AffinityBadge extends StatelessWidget {
  const AffinityBadge(this.level, {super.key});
  final AffinityLevel level;

  @override
  Widget build(BuildContext context) {
    final label = switch (level) {
      AffinityLevel.high => context.l10n.priorityHigh,
      AffinityLevel.medium => context.l10n.priorityMedium,
      AffinityLevel.low => context.l10n.priorityLow,
      AffinityLevel.unknown => context.l10n.affinityUnknown,
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EFFF),
        borderRadius: AppRadii.border,
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.dashboardAccent,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
