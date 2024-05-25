import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixit_partner/features/features.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'electronic_model.freezed.dart';
part 'electronic_model.g.dart';

@freezed
class ElectronicModel with _$ElectronicModel {
  factory ElectronicModel({
    String? id,
    String? name,
    String? description,
    String? image,
    List<String>? gripe,
  }) = _ElectronicModel;

  ElectronicModel._();

  factory ElectronicModel.fromJson(Map<String, dynamic> json) =>
      _$ElectronicModelFromJson(json);

  Electronic toEntity() => Electronic(
        id: id,
        name: name,
        description: description,
        image: image,
        gripe: gripe,
      );

  factory ElectronicModel.fromFirestore(
          DocumentSnapshot snapshot, SnapshotOptions? options) =>
      ElectronicModel.fromJson(snapshot.data() as Map<String, dynamic>);

  static Map<String, dynamic> toFirestore(
          ElectronicModel electronicModel, SetOptions? options) =>
      electronicModel.toJson();
}
