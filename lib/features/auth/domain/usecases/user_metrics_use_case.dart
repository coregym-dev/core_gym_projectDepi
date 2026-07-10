import 'dart:io';

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
      goal: params.goal,
      gender: params.gender,
      imageFile: params.imageFile,
    );
  }
}

class UpdateMetricsParams {
  final String uid;
  final double height;
  final double weight;
  final String goal;
  final String gender;
  final File? imageFile;

  UpdateMetricsParams({
    required this.uid,
    required this.height,
    required this.weight,
    required this.goal,
    required this.gender,
    this.imageFile,
  });
}
