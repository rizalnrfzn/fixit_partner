import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:latlong2/latlong.dart';

abstract class GeolocationRepository {
  Future<Either<Failure, Geolocation>> getLocation();

  Future<Either<Failure, Geolocation>> changeLocation(
      ChangeLocationParams params);

  Stream<LatLng> streamLocation();
}
