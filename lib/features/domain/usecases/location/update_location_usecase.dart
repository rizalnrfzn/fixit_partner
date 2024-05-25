import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/domain/domain.dart';
import 'package:latlong2/latlong.dart';

class UpdateLocationUsecse extends UseCase<LatLng, UpdateLocationParams> {
  final GeolocationRepository _repository;

  UpdateLocationUsecse(this._repository);

  @override
  Future<Either<Failure, LatLng>> call(UpdateLocationParams params) =>
      _repository.updateLocation(params);
}

class UpdateLocationParams {
  final LatLng latLng;

  UpdateLocationParams(this.latLng);
}
