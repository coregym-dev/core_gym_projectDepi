abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  const ServerFailure(super.errMessage);
}

class CacheFailure extends Failure {
  const CacheFailure(super.errMessage);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.errMessage);
}
