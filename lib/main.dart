import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/app/app.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/features/invitations/presentation/bloc/invitation_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()..add(const AuthSessionRequested()),
        ),
        BlocProvider(
          create: (_) =>
              getIt<InvitationBloc>()..add(const InvitationsRequested()),
        ),
      ],
      child: const TalexApp(),
    ),
  );
}
