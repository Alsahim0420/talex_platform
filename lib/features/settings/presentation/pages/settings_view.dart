import 'package:flutter/material.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
import 'package:talex_platform/core/widgets/language_selector.dart';
import 'package:talex_platform/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:talex_platform/l10n/l10n.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final _organization = TextEditingController(text: 'TaleX');
  bool _candidateUpdates = true;
  bool _weeklyDigest = true;
  bool _twoFactor = false;

  @override
  void dispose() {
    _organization.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 760;
      final pagePadding = compact ? 18.0 : 40.0;
      final organizationFields = [
        SettingsTextField(
          label: context.l10n.organizationName,
          controller: _organization,
        ),
        SettingsDropdown(
          label: context.l10n.industry,
          value: context.l10n.technologyIndustry,
          items: [context.l10n.technologyIndustry],
          onChanged: (_) {},
        ),
        SettingsDropdown(
          label: context.l10n.companySize,
          value: context.l10n.employeesRange,
          items: [context.l10n.employeesRange],
          onChanged: (_) {},
        ),
        SettingsDropdown(
          label: context.l10n.timezone,
          value: context.l10n.timezoneBogota,
          items: [context.l10n.timezoneBogota],
          onChanged: _noop,
        ),
      ];
      return SingleChildScrollView(
        padding: EdgeInsets.all(pagePadding),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1180),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 18,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.settingsTitle,
                          style: TextStyle(
                            color: AppColors.ink,
                            fontSize: compact ? 34 : 42,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.settingsSubtitle,
                          style: const TextStyle(
                            color: AppColors.subtitle,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: () => getIt<NotificationService>().success(
                        context.l10n.changesSaved,
                      ),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primaryButton,
                      ),
                      icon: const Icon(Icons.save_outlined),
                      label: Text(context.l10n.saveChanges),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SettingsSection(
                  title: context.l10n.language,
                  description: context.l10n.languageDescription,
                  icon: Icons.language,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: LanguageSelector(),
                  ),
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.organizationProfile,
                  description: context.l10n.organizationDescription,
                  icon: Icons.business_outlined,
                  child: GridView.count(
                    crossAxisCount: compact ? 1 : 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: compact ? 5.2 : 5.8,
                    children: organizationFields,
                  ),
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.notificationsTitle,
                  description: context.l10n.notificationsDescription,
                  icon: Icons.notifications_none,
                  child: Column(
                    children: [
                      SettingsToggle(
                        title: context.l10n.candidateUpdates,
                        description: context.l10n.candidateUpdatesDescription,
                        value: _candidateUpdates,
                        onChanged: (value) =>
                            setState(() => _candidateUpdates = value),
                      ),
                      SettingsToggle(
                        title: context.l10n.weeklyDigest,
                        description: context.l10n.weeklyDigestDescription,
                        value: _weeklyDigest,
                        onChanged: (value) =>
                            setState(() => _weeklyDigest = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SettingsSection(
                  title: context.l10n.securityTitle,
                  description: context.l10n.securityDescription,
                  icon: Icons.shield_outlined,
                  child: Column(
                    children: [
                      SettingsToggle(
                        title: context.l10n.twoFactorAuth,
                        description: context.l10n.twoFactorDescription,
                        value: _twoFactor,
                        onChanged: (value) =>
                            setState(() => _twoFactor = value),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              context.l10n.sessionTimeout,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(context.l10n.minutes30),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {},
                            child: Text(context.l10n.manageMembers),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      );
    },
  );

  static void _noop(String? _) {}
}
