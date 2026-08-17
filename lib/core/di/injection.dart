import 'package:get_it/get_it.dart';
import 'package:talex_platform/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talex_platform/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:talex_platform/features/auth/domain/repositories/auth_repository.dart';
import 'package:talex_platform/features/auth/domain/usecases/auth_usecases.dart';
import 'package:talex_platform/features/auth/presentation/bloc/auth_bloc.dart';

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
    );
}
