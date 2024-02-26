import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/error/failure.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:latlong2/latlong.dart';

class GeolocationRepositoryImpl implements GeolocationRepository {
  final GeolocationRemoteDatasource _datasource;

  GeolocationRepositoryImpl(this._datasource);

  @override
  Future<Either<Failure, Geolocation>> getLocation() async {
    final response = await _datasource.getLocation();

    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r.toEntity());
      },
    );
  }

  @override
  Future<Either<Failure, Geolocation>> changeLocation(
      ChangeLocationParams params) async {
    final response = await _datasource.changeLocation(params);

    return response.fold(
      (l) {
        return Left(l);
      },
      (r) {
        return Right(r.toEntity());
      },
    );
  }

  @override
  Stream<LatLng> streamLocation() async* {
    try {
      yield* _datasource
          .streamLocation()
          .map((event) => LatLng(event.latitude, event.longitude));
    } catch (e) {
      yield* Stream.error(e);
    }
  }
}
