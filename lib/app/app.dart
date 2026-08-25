import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/core/constants/app_colors.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/core/services/notification_service.dart';
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
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    localeListResolutionCallback: (locales, supportedLocales) {
      for (final locale in locales ?? const <Locale>[]) {
        for (final supported in supportedLocales) {
          if (locale.languageCode == supported.languageCode) return supported;
        }
      }
      return const Locale('es');
    },
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.accent),
      useMaterial3: true,
    ),
    routes: {RegisterPage.routeName: (_) => const RegisterPage()},
    home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => switch (state.status) {
        AuthStatus.authenticated => BlocProvider(
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
