// core/error/failures.dart
abstract class Failure {
  final String message;
  const Failure({required this.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}