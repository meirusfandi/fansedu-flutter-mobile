import 'package:fansedu_flutter_mobile/core/error/failures.dart';
import 'package:dartz/dartz.dart';

/// Base use case. [Type] is return type, [Params] is input (use [NoParams] when none).
/// Returns [Either<Failure, Type>] - Left for failure, Right for success.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {
  const NoParams();
}
