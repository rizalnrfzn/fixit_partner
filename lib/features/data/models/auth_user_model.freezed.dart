// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) {
  return _AuthUserModel.fromJson(json);
}

/// @nodoc
mixin _$AuthUserModel {
  String? get uid => throw _privateConstructorUsedError;
  set uid(String? value) => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  set name(String? value) => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  set email(String? value) => throw _privateConstructorUsedError;
  bool? get isRegistered => throw _privateConstructorUsedError;
  set isRegistered(bool? value) => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  set phoneNumber(String? value) => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  set description(String? value) => throw _privateConstructorUsedError;
  String? get profilePicture => throw _privateConstructorUsedError;
  set profilePicture(String? value) => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  set images(List<String>? value) => throw _privateConstructorUsedError;
  List<String>? get files => throw _privateConstructorUsedError;
  set files(List<String>? value) => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;
  set address(String? value) => throw _privateConstructorUsedError;
  @LatLngConverter()
  LatLng? get location => throw _privateConstructorUsedError;
  @LatLngConverter()
  set location(LatLng? value) => throw _privateConstructorUsedError;
  @LatLngConverter()
  LatLng? get currentLocation => throw _privateConstructorUsedError;
  @LatLngConverter()
  set currentLocation(LatLng? value) => throw _privateConstructorUsedError;
  List<String>? get electronics => throw _privateConstructorUsedError;
  set electronics(List<String>? value) => throw _privateConstructorUsedError;
  bool? get isVerified => throw _privateConstructorUsedError;
  set isVerified(bool? value) => throw _privateConstructorUsedError;
  bool? get isOnline => throw _privateConstructorUsedError;
  set isOnline(bool? value) => throw _privateConstructorUsedError;
  bool? get inOrder => throw _privateConstructorUsedError;
  set inOrder(bool? value) => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  set rating(double? value) => throw _privateConstructorUsedError;
  int? get numberOfReviews => throw _privateConstructorUsedError;
  set numberOfReviews(int? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthUserModelCopyWith<AuthUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthUserModelCopyWith<$Res> {
  factory $AuthUserModelCopyWith(
          AuthUserModel value, $Res Function(AuthUserModel) then) =
      _$AuthUserModelCopyWithImpl<$Res, AuthUserModel>;
  @useResult
  $Res call(
      {String? uid,
      String? name,
      String? email,
      bool? isRegistered,
      String? phoneNumber,
      String? description,
      String? profilePicture,
      List<String>? images,
      List<String>? files,
      String? address,
      @LatLngConverter() LatLng? location,
      @LatLngConverter() LatLng? currentLocation,
      List<String>? electronics,
      bool? isVerified,
      bool? isOnline,
      bool? inOrder,
      double? rating,
      int? numberOfReviews});
}

/// @nodoc
class _$AuthUserModelCopyWithImpl<$Res, $Val extends AuthUserModel>
    implements $AuthUserModelCopyWith<$Res> {
  _$AuthUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? isRegistered = freezed,
    Object? phoneNumber = freezed,
    Object? description = freezed,
    Object? profilePicture = freezed,
    Object? images = freezed,
    Object? files = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? currentLocation = freezed,
    Object? electronics = freezed,
    Object? isVerified = freezed,
    Object? isOnline = freezed,
    Object? inOrder = freezed,
    Object? rating = freezed,
    Object? numberOfReviews = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistered: freezed == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      electronics: freezed == electronics
          ? _value.electronics
          : electronics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      inOrder: freezed == inOrder
          ? _value.inOrder
          : inOrder // ignore: cast_nullable_to_non_nullable
              as bool?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      numberOfReviews: freezed == numberOfReviews
          ? _value.numberOfReviews
          : numberOfReviews // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthUserModelImplCopyWith<$Res>
    implements $AuthUserModelCopyWith<$Res> {
  factory _$$AuthUserModelImplCopyWith(
          _$AuthUserModelImpl value, $Res Function(_$AuthUserModelImpl) then) =
      __$$AuthUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? name,
      String? email,
      bool? isRegistered,
      String? phoneNumber,
      String? description,
      String? profilePicture,
      List<String>? images,
      List<String>? files,
      String? address,
      @LatLngConverter() LatLng? location,
      @LatLngConverter() LatLng? currentLocation,
      List<String>? electronics,
      bool? isVerified,
      bool? isOnline,
      bool? inOrder,
      double? rating,
      int? numberOfReviews});
}

/// @nodoc
class __$$AuthUserModelImplCopyWithImpl<$Res>
    extends _$AuthUserModelCopyWithImpl<$Res, _$AuthUserModelImpl>
    implements _$$AuthUserModelImplCopyWith<$Res> {
  __$$AuthUserModelImplCopyWithImpl(
      _$AuthUserModelImpl _value, $Res Function(_$AuthUserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? isRegistered = freezed,
    Object? phoneNumber = freezed,
    Object? description = freezed,
    Object? profilePicture = freezed,
    Object? images = freezed,
    Object? files = freezed,
    Object? address = freezed,
    Object? location = freezed,
    Object? currentLocation = freezed,
    Object? electronics = freezed,
    Object? isVerified = freezed,
    Object? isOnline = freezed,
    Object? inOrder = freezed,
    Object? rating = freezed,
    Object? numberOfReviews = freezed,
  }) {
    return _then(_$AuthUserModelImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      isRegistered: freezed == isRegistered
          ? _value.isRegistered
          : isRegistered // ignore: cast_nullable_to_non_nullable
              as bool?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePicture: freezed == profilePicture
          ? _value.profilePicture
          : profilePicture // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      files: freezed == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      currentLocation: freezed == currentLocation
          ? _value.currentLocation
          : currentLocation // ignore: cast_nullable_to_non_nullable
              as LatLng?,
      electronics: freezed == electronics
          ? _value.electronics
          : electronics // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isVerified: freezed == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool?,
      isOnline: freezed == isOnline
          ? _value.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
      inOrder: freezed == inOrder
          ? _value.inOrder
          : inOrder // ignore: cast_nullable_to_non_nullable
              as bool?,
      rating: freezed == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double?,
      numberOfReviews: freezed == numberOfReviews
          ? _value.numberOfReviews
          : numberOfReviews // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuthUserModelImpl extends _AuthUserModel {
  _$AuthUserModelImpl(
      {this.uid,
      this.name,
      this.email,
      this.isRegistered,
      this.phoneNumber,
      this.description,
      this.profilePicture,
      this.images,
      this.files,
      this.address,
      @LatLngConverter() this.location,
      @LatLngConverter() this.currentLocation,
      this.electronics,
      this.isVerified,
      this.isOnline,
      this.inOrder,
      this.rating,
      this.numberOfReviews})
      : super._();

  factory _$AuthUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthUserModelImplFromJson(json);

  @override
  String? uid;
  @override
  String? name;
  @override
  String? email;
  @override
  bool? isRegistered;
  @override
  String? phoneNumber;
  @override
  String? description;
  @override
  String? profilePicture;
  @override
  List<String>? images;
  @override
  List<String>? files;
  @override
  String? address;
  @override
  @LatLngConverter()
  LatLng? location;
  @override
  @LatLngConverter()
  LatLng? currentLocation;
  @override
  List<String>? electronics;
  @override
  bool? isVerified;
  @override
  bool? isOnline;
  @override
  bool? inOrder;
  @override
  double? rating;
  @override
  int? numberOfReviews;

  @override
  String toString() {
    return 'AuthUserModel(uid: $uid, name: $name, email: $email, isRegistered: $isRegistered, phoneNumber: $phoneNumber, description: $description, profilePicture: $profilePicture, images: $images, files: $files, address: $address, location: $location, currentLocation: $currentLocation, electronics: $electronics, isVerified: $isVerified, isOnline: $isOnline, inOrder: $inOrder, rating: $rating, numberOfReviews: $numberOfReviews)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      __$$AuthUserModelImplCopyWithImpl<_$AuthUserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthUserModelImplToJson(
      this,
    );
  }
}

abstract class _AuthUserModel extends AuthUserModel {
  factory _AuthUserModel(
      {String? uid,
      String? name,
      String? email,
      bool? isRegistered,
      String? phoneNumber,
      String? description,
      String? profilePicture,
      List<String>? images,
      List<String>? files,
      String? address,
      @LatLngConverter() LatLng? location,
      @LatLngConverter() LatLng? currentLocation,
      List<String>? electronics,
      bool? isVerified,
      bool? isOnline,
      bool? inOrder,
      double? rating,
      int? numberOfReviews}) = _$AuthUserModelImpl;
  _AuthUserModel._() : super._();

  factory _AuthUserModel.fromJson(Map<String, dynamic> json) =
      _$AuthUserModelImpl.fromJson;

  @override
  String? get uid;
  set uid(String? value);
  @override
  String? get name;
  set name(String? value);
  @override
  String? get email;
  set email(String? value);
  @override
  bool? get isRegistered;
  set isRegistered(bool? value);
  @override
  String? get phoneNumber;
  set phoneNumber(String? value);
  @override
  String? get description;
  set description(String? value);
  @override
  String? get profilePicture;
  set profilePicture(String? value);
  @override
  List<String>? get images;
  set images(List<String>? value);
  @override
  List<String>? get files;
  set files(List<String>? value);
  @override
  String? get address;
  set address(String? value);
  @override
  @LatLngConverter()
  LatLng? get location;
  @LatLngConverter()
  set location(LatLng? value);
  @override
  @LatLngConverter()
  LatLng? get currentLocation;
  @LatLngConverter()
  set currentLocation(LatLng? value);
  @override
  List<String>? get electronics;
  set electronics(List<String>? value);
  @override
  bool? get isVerified;
  set isVerified(bool? value);
  @override
  bool? get isOnline;
  set isOnline(bool? value);
  @override
  bool? get inOrder;
  set inOrder(bool? value);
  @override
  double? get rating;
  set rating(double? value);
  @override
  int? get numberOfReviews;
  set numberOfReviews(int? value);
  @override
  @JsonKey(ignore: true)
  _$$AuthUserModelImplCopyWith<_$AuthUserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
