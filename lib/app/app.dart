import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/features/auth/presentation/pages/auth_page.dart';

class TalexApp extends StatelessWidget {
  const TalexApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'TaleX',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1C59D9)),
      useMaterial3: true,
    ),
    home: BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) => switch (state.status) {
        AuthStatus.authenticated => const _DashboardPage(),
        AuthStatus.initial => const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
        _ => const AuthPage(),
      },
    ),
  );
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();
  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TaleX'),
        actions: [
          TextButton.icon(
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthSignOutRequested()),
            icon: const Icon(Icons.logout),
            label: const Text('Cerrar sesión'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Text(
          'Bienvenido, ${user?.displayName ?? user?.email ?? ''}',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
