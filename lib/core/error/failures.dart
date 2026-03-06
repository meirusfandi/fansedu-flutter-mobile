import 'package:equatable/equatable.dart';

/// Base class for all failures in the app.
/// Use [message] for user-facing error text.
abstract class Failure extends Equatable {
  const Failure({this.message = 'Something went wrong'});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
