import 'dart:async';

import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'location_state.dart';
part 'location_cubit.freezed.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(
    this._getLocation,
    this._getDirection,
    this._changeLocation,
    this._streamLocation,
    this._updateLocation,
  ) : super(const LocationState.initial());

  final GetLocationUsecase _getLocation;
  final GetDirectionUsecase _getDirection;
  final ChangeLocationUsecase _changeLocation;
  final StreamLocation _streamLocation;
  final UpdateLocationUsecse _updateLocation;

  StreamSubscription? _locationSubscription;

  Geolocation? geolocation;
  Direction? direction;
  LatLng? currentLocation;

  Future<void> getLocation() async {
    final data = await _getLocation.call(NoParams());

    data.fold(
      (l) {
        if (l is LocationError) {
          emit(_Failure(l.code));
        }
      },
      (r) {
        geolocation = r;
        emit(_Success(geolocation, direction, currentLocation));
      },
    );
  }

  Future<Geolocation?> changeLocation(LatLng location) async {
    final data =
        await _changeLocation.call(ChangeLocationParams(location: location));

    data.fold(
      (l) {
        if (l is LocationError) {
          emit(_Failure(l.code));
        }
      },
      (r) {
        geolocation = r;
        return r;
      },
    );
    return null;
  }

  Future<void> changeCurrentLocation(LatLng location) async {
    await changeLocation(location);
    emit(_Success(geolocation, direction, currentLocation));
  }

  Future<void> getDirection(LatLng destinationLocation) async {
    await getLocation();

    final data = await _getDirection
        .call(DirectionParams(geolocation!.location!, destinationLocation));

    data.fold(
      (l) {
        emit(_Failure(l.toString()));
      },
      (r) {
        direction = r;
        emit(_Success(geolocation, direction, currentLocation));
      },
    );
  }

  Future<void> changeDirection(
      LatLng location, LatLng destinationLocation) async {
    await changeLocation(location);

    final data = await _getDirection
        .call(DirectionParams(geolocation!.location!, destinationLocation));

    data.fold(
      (l) {
        emit(_Failure(l.toString()));
      },
      (r) {
        direction = r;
        emit(_Success(geolocation, direction, currentLocation));
      },
    );
  }

  Future<void> updateLocation(LatLng latlng) async {
    final data = await _updateLocation.call(UpdateLocationParams(latlng));

    data.fold(
      (l) {
        if (l is FirestoreFailure) {
          emit(_Failure(l.code));
        }
      },
      (r) => null,
    );
  }

  void streamLocation() async {
    _locationSubscription?.cancel();
    _locationSubscription = _streamLocation.call().listen(
      (event) async {
        currentLocation = event;
        await updateLocation(event);
        Future.delayed(const Duration(seconds: 2));
        emit(_Success(geolocation, direction, currentLocation));
      },
    );
  }

  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}
