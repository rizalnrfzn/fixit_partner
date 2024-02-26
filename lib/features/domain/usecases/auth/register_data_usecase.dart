import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class RegisterDataUsecase extends UseCase<AuthUser, RegisterDataParams> {
  final AuthRepository _repository;

  RegisterDataUsecase(this._repository);

  @override
  Future<Either<Failure, AuthUser>> call(RegisterDataParams params) =>
      _repository.registerData(params);
}

class RegisterDataParams {
  final AuthUser userData;
  final File? profilePicture;
  final List<File> images;
  final List<File> files;

  RegisterDataParams({
    required this.userData,
    this.profilePicture,
    required this.images,
    required this.files,
  });
}
