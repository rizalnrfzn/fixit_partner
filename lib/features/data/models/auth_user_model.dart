import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:fixit_partner/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'auth_user_model.freezed.dart';
part 'auth_user_model.g.dart';

@unfreezed
class AuthUserModel with _$AuthUserModel {
  factory AuthUserModel({
    String? uid,
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
    int? numberOfReviews,
  }) = _AuthUserModel;

  AuthUserModel._();

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  factory AuthUserModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      AuthUserModel.fromJson(snapshot.data() as Map<String, dynamic>);

  static Map<String, dynamic> toFirestore(
          AuthUserModel object, SetOptions? options) =>
      object.toJson();

  AuthUser toEntity() => AuthUser(
        uid: uid,
        name: name,
        email: email,
        isRegistered: isRegistered,
        phoneNumber: phoneNumber,
        description: description,
        profilePicture: profilePicture,
        images: images,
        address: address,
        location: location,
        currentLocation: currentLocation,
        electronics: electronics,
        isVerified: isVerified,
        isOnline: isOnline,
        inOrder: inOrder,
        rating: rating,
        numberOfReviews: numberOfReviews,
      );
}
