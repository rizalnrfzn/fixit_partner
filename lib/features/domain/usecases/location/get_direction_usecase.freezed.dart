// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_direction_usecase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DirectionParams _$DirectionParamsFromJson(Map<String, dynamic> json) {
  return _DirectionParams.fromJson(json);
}

/// @nodoc
mixin _$DirectionParams {
  LatLng? get location => throw _privateConstructorUsedError;
  LatLng? get destinationLocation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DirectionParamsCopyWith<DirectionParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectionParamsCopyWith<$Res> {
  factory $DirectionParamsCopyWith(
          DirectionParams value, $Res Function(DirectionParams) then) =
      _$DirectionParamsCopyWithImpl<$Res, DirectionParams>;
  @useResult
  $Res call({LatLng? location, LatLng? destinationLocation});
}

/// @nodoc
class _$DirectionParamsCopyWithImpl<$Res, $Val extends DirectionParams>
    implements $DirectionParamsCopyWith<$Res> {
  _$DirectionParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? destinationLocation = freezed,
  }) {
    return _then(_value.copyWith(
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      destinationLocation: freezed == destinationLocation
          ? _value.destinationLocation
          : destinationLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DirectionParamsImplCopyWith<$Res>
    implements $DirectionParamsCopyWith<$Res> {
  factory _$$DirectionParamsImplCopyWith(_$DirectionParamsImpl value,
          $Res Function(_$DirectionParamsImpl) then) =
      __$$DirectionParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LatLng? location, LatLng? destinationLocation});
}

/// @nodoc
class __$$DirectionParamsImplCopyWithImpl<$Res>
    extends _$DirectionParamsCopyWithImpl<$Res, _$DirectionParamsImpl>
    implements _$$DirectionParamsImplCopyWith<$Res> {
  __$$DirectionParamsImplCopyWithImpl(
      _$DirectionParamsImpl _value, $Res Function(_$DirectionParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? location = freezed,
    Object? destinationLocation = freezed,
  }) {
    return _then(_$DirectionParamsImpl(
      freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      freezed == destinationLocation
          ? _value.destinationLocation
          : destinationLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DirectionParamsImpl implements _DirectionParams {
  _$DirectionParamsImpl(this.location, this.destinationLocation);

  factory _$DirectionParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DirectionParamsImplFromJson(json);

  @override
  final LatLng? location;
  @override
  final LatLng? destinationLocation;

  @override
  String toString() {
    return 'DirectionParams(location: $location, destinationLocation: $destinationLocation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DirectionParamsImpl &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.destinationLocation, destinationLocation) ||
                other.destinationLocation == destinationLocation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, location, destinationLocation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DirectionParamsImplCopyWith<_$DirectionParamsImpl> get copyWith =>
      __$$DirectionParamsImplCopyWithImpl<_$DirectionParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DirectionParamsImplToJson(
      this,
    );
  }
}

abstract class _DirectionParams implements DirectionParams {
  factory _DirectionParams(
          final LatLng? location, final LatLng? destinationLocation) =
      _$DirectionParamsImpl;

  factory _DirectionParams.fromJson(Map<String, dynamic> json) =
      _$DirectionParamsImpl.fromJson;

  @override
  LatLng? get location;
  @override
  LatLng? get destinationLocation;
  @override
  @JsonKey(ignore: true)
  _$$DirectionParamsImplCopyWith<_$DirectionParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
