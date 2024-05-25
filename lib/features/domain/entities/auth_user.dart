import 'package:fixit_partner/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'auth_user.freezed.dart';

@unfreezed
class AuthUser with _$AuthUser {
  factory AuthUser({
    String? uid,
    String? name,
    String? email,
    bool? isRegistered,
    String? phoneNumber,
    String? description,
    String? profilePicture,
    List<String>? images,
    String? address,
    LatLng? location,
    LatLng? currentLocation,
    List<String>? electronicId,
    bool? isVerified,
    bool? isOnline,
    bool? inOrder,
    double? rating,
    int? numberOfReviews,
    Direction? direction,
  }) = _AuthUser;

  AuthUser._();

  AuthUserModel toModel() => AuthUserModel(
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
        electronicId: electronicId,
        isVerified: isVerified,
        isOnline: isOnline,
        inOrder: inOrder,
        rating: rating,
        numberOfReviews: numberOfReviews,
      );
}
