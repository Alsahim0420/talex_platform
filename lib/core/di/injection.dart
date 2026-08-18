import 'package:get_it/get_it.dart';
import 'package:talex_platform/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talex_platform/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:talex_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:talex_platform/features/auth/domain/usecases/auth_usecases.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:talex_platform/features/invitations/data/datasources/invitation_data_source.dart';
import 'package:talex_platform/features/invitations/data/repositories/invitation_repository_impl.dart';
import 'package:talex_platform/features/invitations/domain/repositories/invitation_repository.dart';
import 'package:talex_platform/features/invitations/domain/usecases/invitation_usecases.dart';
import 'package:talex_platform/features/invitations/presentation/bloc/invitation_bloc.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  getIt
    ..registerLazySingleton<AuthRemoteDataSource>(
      InMemoryAuthRemoteDataSource.new,
    )
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()))
    ..registerLazySingleton(() => SignIn(getIt()))
    ..registerLazySingleton(() => SignUp(getIt()))
    ..registerLazySingleton(() => SignOut(getIt()))
    ..registerLazySingleton(() => GetCurrentUser(getIt()))
    ..registerLazySingleton(() => SendPasswordResetEmail(getIt()))
    ..registerFactory(
      () => AuthBloc(
        signIn: getIt(),
        signUp: getIt(),
        signOut: getIt(),
        getCurrentUser: getIt(),
        sendPasswordResetEmail: getIt(),
      ),
    )
    ..registerLazySingleton<InvitationDataSource>(
      InMemoryInvitationDataSource.new,
    )
    ..registerLazySingleton<InvitationRepository>(
      () => InvitationRepositoryImpl(getIt()),
    )
    ..registerLazySingleton(() => GetInvitations(getIt()))
    ..registerLazySingleton(() => CreateInvitation(getIt()))
    ..registerLazySingleton(() => ResendInvitation(getIt()))
    ..registerLazySingleton(() => CancelInvitation(getIt()))
    ..registerFactory(
      () => InvitationBloc(
        getInvitations: getIt(),
        createInvitation: getIt(),
        resendInvitation: getIt(),
        cancelInvitation: getIt(),
      ),
    );
}
