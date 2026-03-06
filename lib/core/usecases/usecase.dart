import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// Base use case. [T] is return type, [Params] is input (use [NoParams] when none).
/// Returns [Either<Failure, T>] - Left for failure, Right for success.
abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

class NoParams {
  const NoParams();
}
