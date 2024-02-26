import 'package:fixit_partner/features/features.dart';
import 'package:latlong2/latlong.dart';

class StreamLocation {
  final GeolocationRepository _repository;

  StreamLocation(this._repository);

  Stream<LatLng> call() => _repository.streamLocation();
}
