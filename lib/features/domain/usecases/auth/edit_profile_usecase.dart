import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class EditProfileUsecase extends UseCase<AuthUser, EditProfileParams> {
  final AuthRepository _repository;

  EditProfileUsecase(this._repository);

  @override
  Future<Either<Failure, AuthUser>> call(EditProfileParams params) =>
      _repository.editProfile(params);
}

class EditProfileParams {
  final AuthUser userData;
  File? newProfilePicture;
  List<String> oldImages;
  List<File> newImages;

  EditProfileParams({
    required this.userData,
    this.newProfilePicture,
    required this.oldImages,
    required this.newImages,
  });
}
