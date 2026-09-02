import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
import 'package:talex_platform/features/admin/presentation/bloc/admin_bloc.dart';
import 'package:talex_platform/features/admin/presentation/pages/admin_shell.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/features/auth/presentation/pages/auth_page.dart';
import 'package:talex_platform/features/auth/presentation/pages/register_page.dart';
import 'package:talex_platform/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:talex_platform/features/invitations/presentation/bloc/invitation_bloc.dart';
import 'package:talex_platform/l10n/app_localizations.dart';

class TalexApp extends StatelessWidget {
  const TalexApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    navigatorKey: getIt<NotificationService>().navigatorKey,
    title: 'TaleX',
    debugShowCheckedModeBanner: false,
    locale: const Locale('es'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
      useMaterial3: true,
    ),
    routes: {RegisterPage.routeName: (_) => const RegisterPage()},
    home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => switch (state.status) {
        AuthStatus.authenticated => state.user?.isSuperAdmin == true
          ? BlocProvider(
              create: (_) {
                configureAdminDependencies();
                return getIt<AdminBloc>()..add(const AdminDashboardRequested());
              },
              child: const AdminShell(),
            )
          : BlocProvider(
              create: (_) {
                configureInvitationDependencies();
                return getIt<InvitationBloc>()..add(const InvitationsRequested());
              },
              child: const DashboardPage(),
            ),
        AuthStatus.initial => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        _ => const AuthPage(),
      },
    ),
  );
}
