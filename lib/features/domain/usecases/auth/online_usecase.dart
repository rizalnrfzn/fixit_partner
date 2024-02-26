import 'package:dartz/dartz.dart';
import 'package:fixit_partner/core/core.dart';
import 'package:fixit_partner/features/features.dart';

class OnlineUsecase extends UseCase<AuthUser, AuthUser> {
  final AuthRepository _repository;

  OnlineUsecase(this._repository);

  @override
  Future<Either<Failure, AuthUser>> call(AuthUser params) =>
      _repository.online(params);
}
