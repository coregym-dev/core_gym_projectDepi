import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth.repository.dart';

class UpdateMetricsUseCase {
  final AuthRepository repository;

  UpdateMetricsUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateMetricsParams params) async {
    return await repository.updateUserMetrics(
      uid: params.uid,
      height: params.height,
      weight: params.weight,
    );
  }
}

class UpdateMetricsParams {
  final String uid;
  final double height;
  final double weight;

  UpdateMetricsParams({
    required this.uid,
    required this.height,
    required this.weight,
  });
}
