import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

abstract class DirectionRepository {
  Future<Either<Failure, Direction>> getDirection(DirectionParams params);
}
