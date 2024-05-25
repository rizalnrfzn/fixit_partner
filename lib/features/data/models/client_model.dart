import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'client_model.freezed.dart';
part 'client_model.g.dart';

@freezed
class ClientModel with _$ClientModel {
  factory ClientModel({
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicture,
    String? address,
    String? location,
    bool? isRegistered,
  }) = _ClientModel;

  ClientModel._();

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      _$ClientModelFromJson(json);

  Client toEntity() => Client(
        uid: uid,
        name: name,
        email: email,
        phoneNumber: phoneNumber,
        profilePicture: profilePicture,
        address: address,
        location: location,
        isRegistered: isRegistered,
      );

  factory ClientModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      ClientModel.fromJson(snapshot.data() as Map<String, dynamic>);

  static Map<String, dynamic> toFirestore(
          ClientModel clientModel, SetOptions? options) =>
      clientModel.toJson();
}
