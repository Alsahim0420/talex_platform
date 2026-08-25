import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talex_platform/app/app.dart';
import 'package:talex_platform/core/di/injection.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  runApp(
    BlocProvider(
      create: (_) => getIt<AuthBloc>()..add(const AuthSessionRequested()),
      child: const TalexApp(),
    ),
  );
}
