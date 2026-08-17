import 'package:dartz/dartz.dart';
import 'package:talex_platform/core/error/failure.dart';

abstract interface class UseCase<Result, Params> {
  Future<Either<Failure, Result>> call(Params params);
}

class NoParams {
  const NoParams();
}
