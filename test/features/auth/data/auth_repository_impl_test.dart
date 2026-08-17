import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talex_platform/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:talex_platform/features/auth/data/repositories/auth_repository_impl.dart';

void main() {
  late AuthRepositoryImpl repository;

  setUp(() => repository = AuthRepositoryImpl(InMemoryAuthRemoteDataSource()));

  test('signUp maps the data model to a domain entity', () async {
    final result = await repository.signUp(
      email: 'equipo@talex.com.co',
      password: 'secret1',
      displayName: 'TaleX',
    );
    expect(result.isRight(), isTrue);
    result.fold((failure) => fail(failure.message), (user) {
      expect(user.email, 'equipo@talex.com.co');
      expect(user.displayName, 'TaleX');
    });
  });

  test('invalid credentials return a Failure', () async {
    final result = await repository.signIn(email: 'invalid', password: '123');
    expect(result.isLeft(), isTrue);
  });

  test('signOut clears the current session', () async {
    await repository.signIn(email: 'equipo@talex.com.co', password: 'secret1');
    expect(await repository.signOut(), const Right(unit));
    (await repository.getCurrentUser()).fold(
      (failure) => fail(failure.message),
      (user) => expect(user, isNull),
    );
  });
}
