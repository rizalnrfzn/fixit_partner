import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class GetLocationUsecase extends UseCase<Geolocation, NoParams> {
  final GeolocationRepository _repository;

  GetLocationUsecase(this._repository);

  @override
  Future<Either<Failure, Geolocation>> call(NoParams params) =>
      _repository.getLocation();
}
